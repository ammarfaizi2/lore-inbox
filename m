Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVAYHbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVAYHbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVAYHbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:31:38 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:26777 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261852AbVAYHbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:31:36 -0500
To: s.b.wielinga@student.utwente.nl
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050125000339.GA610@speedy.student.utwente.nl> (message from
	Sytse Wielinga on Tue, 25 Jan 2005 01:03:39 +0100)
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125000339.GA610@speedy.student.utwente.nl>
Message-Id: <E1CtLAT-0006Bm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Jan 2005 08:31:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > fuse-transfer-readdir-data-through-device.patch
> >   fuse: transfer readdir data through device
> It is great that this is fixed, don't remove it, but it does require the fuse
> libs to be updated at the same time, or opening dirs for listings will break
> like this:
> 
> open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOSYS (Function
> not implemented)
> 
> As I personally like for my ls to keep on working, and I assume
> others will, too, I would appreciate it if you could add a warning
> to your announcements the following one or two weeks or so, so that
> people can remove this patch if they don't want to update their
> libs.

This is my fault, sorry.

I promise, that there'll be no more backward incompatible changes (and
if there will, a big warning about library dependency will be added :).

Thanks,
Miklos
