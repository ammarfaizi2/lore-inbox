Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBNOKq>; Wed, 14 Feb 2001 09:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNOKh>; Wed, 14 Feb 2001 09:10:37 -0500
Received: from smtp5.us.dell.com ([143.166.83.100]:61700 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S129106AbRBNOKW>; Wed, 14 Feb 2001 09:10:22 -0500
Date: Wed, 14 Feb 2001 08:10:18 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: David Balazic <david.balazic@uni-mb.si>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <3A8A7AB0.5D483D5F@uni-mb.si>
Message-ID: <Pine.LNX.4.30.0102140730170.1882-100000@carthage.michaels-house.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, David Balazic wrote:

> Michael E Brown (michael_e_brown@dell.com) worte :
>
> > That has been tried. No, it does not work. :-) Using Scsi-Generic is the
> > only way so far found, but of course, it only works on SCSI drives.
>
> Did you try scsi-emulation on IDE disks ?

I think that scsi-emulation works only for ATAPI devices. CDROMs are
normally ATAPI. HDs are normally just ATA. I don't think that would work,
but I have not tried it, either.
--
Michael Brown
Linux Systems Group
Dell Computer Corp

