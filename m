Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290319AbSAPBXR>; Tue, 15 Jan 2002 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290336AbSAPBWD>; Tue, 15 Jan 2002 20:22:03 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:61967 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290334AbSAPBUR>;
	Tue, 15 Jan 2002 20:20:17 -0500
Date: Tue, 15 Jan 2002 17:16:47 -0800
From: Greg KH <greg@kroah.com>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116011647.GB30103@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <20020115233437.GC29020@kroah.com> <15428.49056.652466.414438@irving.iisd.sra.com> <20020116000117.GD29020@kroah.com> <15428.51789.430278.700907@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15428.51789.430278.700907@irving.iisd.sra.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 23:03:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 07:33:17PM -0500, David Garfield wrote:
> 
> Except that what you have just proposed requires that you "build in
> _all possible_ SCSI PCI drivers" as modules in the initramfs.  Little
> gain, except that some things won't be retained.

Little gain?  You don't waste kernel space for SCSI drivers that are not
being used.

> Further, I don't thing I would expect a system with a changed SCSI PCI
> controller to boot on a kernel specifically built for the previous
> controller.  I don't think I would even want it to boot.  Better I
> think to get out a rescue disk of some sort, boot from that,
> reconfigure a built kernel for the new hardware (in the new case,
> simply reconstructing the initramfs), and reboot from that.

Each to their own.

> What I am worried about is not *allowing* user mode code in the
> initramfs, but *requiring* it.

Why?  What are you afraid of? :)
If you want the boot process to be just like it is today, and you don't
require any network boot stuff, I think no userspace code will be
needed.  But I can't guess the future...

greg k-h
