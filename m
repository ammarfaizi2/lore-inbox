Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTCIGEe>; Sun, 9 Mar 2003 01:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262433AbTCIGEe>; Sun, 9 Mar 2003 01:04:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40463 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262432AbTCIGE3>;
	Sun, 9 Mar 2003 01:04:29 -0500
Date: Sat, 8 Mar 2003 22:04:52 -0800
From: Greg KH <greg@kroah.com>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030309060452.GA28835@kroah.com>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com> <20030308143745.GB7234@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308143745.GB7234@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 03:37:45PM +0100, Anders Gustafsson wrote:
> On Fri, Mar 07, 2003 at 04:43:40PM -0800, Greg KH wrote:
> > 
> > ChangeSet 1.1124, 2003/03/07 16:39:06-08:00, greg@kroah.com
> > 
> > gen_init_cpio: Add the ability to add files to the cpio image.
> 
> Have you been able to boot the kernel with a cpio-archive that contains
> files larger than a few k? The kernel crashes on me when writing to the file
> in ramfs.

I have not tried that, no.

> It crashes i the third or forth flush_window or so..

What does the oops show?

thanks,

greg k-h
