Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUKWN4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUKWN4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKWN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:56:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59629 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261250AbUKWN4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:56:10 -0500
Date: Tue, 23 Nov 2004 14:55:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: fork: add a hook in do_fork()
In-Reply-To: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
Message-ID: <Pine.LNX.4.53.0411231452510.28979@yvahk01.tjqt.qr>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I don't know if this solution is good but it's easy to implement and
>it just does the trick. I made some tests and it doesn't impact the
>performance of the Linux kernel.

Needs 2 additional CPU ops ;-)

>   I'd like to have your comment about this patch. Is it useful and is
>it needed by someone else than me?

Usually no, and I doubt there's a chance to get it in.
It's not something 60% of all kernel users, linux distros and so forth will be
going to use it.

I guess I would have the same bad luck if I was to integrate the rpldev hooks
from ttyrpld.sf.net.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
