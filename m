Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSGXUPB>; Wed, 24 Jul 2002 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSGXUOr>; Wed, 24 Jul 2002 16:14:47 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:13356 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S317539AbSGXUMp>; Wed, 24 Jul 2002 16:12:45 -0400
Date: Wed, 24 Jul 2002 16:15:50 -0400
From: Kareem Dana <kareemy@earthlink.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: arodland@noln.com, linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
Message-Id: <20020724161550.6a852f89.kareemy@earthlink.net>
In-Reply-To: <20020724194130.GB13180@win.tue.nl>
References: <20020724145919.01c79fce.kareemy@earthlink.net>
	<20020724151904.3d719dea.arodland@noln.com>
	<20020724153319.5ebd589b.kareemy@earthlink.net>
	<20020724194130.GB13180@win.tue.nl>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 21:41:30 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> On Wed, Jul 24, 2002 at 03:33:19PM -0400, Kareem Dana wrote:
> 
> > losetup worked like a charm. Thanks. Any reason umount would not do that automatically though?
> 
> Read mount(8), the places where losetup is mentioned.

I compiled my system from scratch following the guide of the LFS. LFS recommends that you create a symbolic link from /proc/mounts to /etc/mtab. After reading the mount man page, that seems to be my problem. mtab shouldnt be a symlink. Thanks for the help. I'm going to e-mail the LFS mailing list about their mtab symlink now
