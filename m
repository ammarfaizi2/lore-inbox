Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUJaGJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUJaGJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUJaGJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:09:34 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:37638 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261508AbUJaGJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:09:30 -0500
Date: Sun, 31 Oct 2004 09:10:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1  A little build system bug I guess
Message-ID: <20041031081023.GA6137@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org> <20041031041700.GA18638@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031041700.GA18638@larroy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 05:17:00AM +0100, Pedro Larroy wrote:
> Gug
> 
> This is a little compile breakage when using -mm to build a kernel with
> make O=directory
> 
> In vanilla 2.6.8 I don't have the problem so I presume I'm not the cause
> for it.
> 
> I attach my config.
> 
> Here comes the output:
> 
> compiling...
> 
>   CC      init/initramfs.o
>   LD      init/built-in.o
>   HOSTCC  usr/gen_init_cpio
>   GEN_INITRAMFS_LIST usr/initramfs_list
> Using shipped usr/initramfs_list
>   CPIO    usr/initramfs_data.cpio
> ERROR: unable to open 'usr/initramfs_list': No such file or directory

Fixed in latest -mm

	Sam
