Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTKFOyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTKFOyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:54:32 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7625 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263627AbTKFOya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:54:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: ide-scsi question: 2x
Date: Thu, 6 Nov 2003 15:58:40 +0100
User-Agent: KMail/1.5.4
References: <20031106115813.GF25124@schottelius.org>
In-Reply-To: <20031106115813.GF25124@schottelius.org>
Cc: gadio@netvision.net.il, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061558.40845.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 of November 2003 12:58, Nico Schottelius wrote:
> Hello!

Hi,

> 1. why is printk used without KERN_* makro?
>    like '        printk("[ ");' (267), ide-scsi from 2.6.0test9, version
> 0.92 (there are more examples)

Because it was not updated to use KERN_*?

> 2. is the command line hdx=ide-scsi still necessary?

Yes, IMO "hdx=driver_name" should be removed instead.

>    -> if not, we should update the help
>    Can't we pass the options via module parameters (if it is a module) ?

It is possible for ide-cd, I don't remember about ide-scsi.
Anyway not modular case is the more difficult one.

>    -> if yes, we should update the help

Dunno.

BTW I don't think you'll get response from gadio.

--bartlomiej

