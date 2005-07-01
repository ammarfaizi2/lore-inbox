Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGAQi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGAQi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbVGAQi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:38:29 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:34531 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261390AbVGAQiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:38:18 -0400
Message-ID: <2873.192.167.206.189.1120235893.squirrel@new.host.name>
In-Reply-To: <f0cc385605070106017d05c0ff@mail.gmail.com>
References: <f0cc385605070106017d05c0ff@mail.gmail.com>
Date: Fri, 1 Jul 2005 18:38:13 +0200 (CEST)
Subject: Re: reiser4 plugins
From: "Luigi Genoni" <genoni@darkstar.linuxpratico.net>
To: "M." <vo.sinh@gmail.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, July 1, 2005 15:01, M. wrote:

> When your hard disk get a bad block you can't keep using it and rely
> on the "badblocks-proof filesystem structure that prevents you to do
> backups"..even with FAT, the simpler filesystem structure around, if you
> keep using you disk you are likely going to loose some data (yes, maybe
> not entire files). But, even with the metadata's richer filesystem, if you
> detect the first badblock you can save almost everything.
problem is when you detect it...
>
> Does it really makes sense to design a filesystem in a way that gives
> users some more time to use their filesystem from the first happened
> badblock or it's better to focus on new features that give better everyday
> use in terms of performance, functionalities, etc ?

to give users more times means that most users will wait more time, but
won't take any action to prevent data loss.
on the other side, I doubt home users are really sensitive about
performances. they do care about performances, but I do not know if they
are able to evaluate performances as well.
even for servers, if they are not stressed, it is difficoult with modern
hardware to evaluate I/O performances.

>
> And, are you sure that users who dont do and dont know they have to do
> backups of sensitive data are able to recover a corrupted filesystem ?
>
My experience taught me they aren't.
but they complain anyway.

