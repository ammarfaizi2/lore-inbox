Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSAPXKX>; Wed, 16 Jan 2002 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSAPXKN>; Wed, 16 Jan 2002 18:10:13 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44562 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282511AbSAPXKA>;
	Wed, 16 Jan 2002 18:10:00 -0500
Date: Wed, 16 Jan 2002 15:06:21 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020116230620.GE3410@kroah.com>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <20020116195105.C18039@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116195105.C18039@devcon.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 19 Dec 2001 20:02:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 07:51:06PM +0100, Andreas Ferber wrote:
> On Tue, Jan 15, 2002 at 05:01:11PM +0100, Olaf Dietsche wrote:
> > 
> > this is a new file system to control access to system resources.
> > Currently it controls access to inet_bind() with ports < 1024 only.
> 
> Just some minor notes from reading the source and docs:
> 
> - It somewhat collides with the Linux Security Module project
>   (http://lsm.immunix.org/).

I don't see this conflicting with what the lsm patch does (with the
minor exception of removing the capable() call.)  How do you see a
conflict here?

This patch looks nice, I like it.

Yet another reason why we should have a bunch of the ramfs functions
exported for the rest of the kernel to use :)

thanks,

greg k-h
