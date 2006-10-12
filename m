Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWJLOU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWJLOU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWJLOU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:20:57 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:20158 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932462AbWJLOU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:20:56 -0400
Date: Thu, 12 Oct 2006 16:19:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: roland <devzero@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: The Future of ReiserFS development
In-Reply-To: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
Message-ID: <Pine.LNX.4.61.0610121615250.28090@yvahk01.tjqt.qr>
References: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > What is the plan? Could i
>> > migrate from reiserfs to another journaling filesystem?
>> 
>> Of course: Simply backup, mkfs and restore!
>
> not that simple if you have hundreds of thousands or even millions of small
> files !
> reiserfs is quite efficient in storing small files.

Depends. While reiser may get a diskspace bonus for packing, xfs and 
others have a time bonus for not packing, and that's more important 
when having lots of files. Disk space is quite cheap nowaedays.

> don`t know if there is anyfilesystem which is as efficient with this.....


	-`J'
-- 
