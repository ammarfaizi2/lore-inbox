Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbSKSSqQ>; Tue, 19 Nov 2002 13:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbSKSSov>; Tue, 19 Nov 2002 13:44:51 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29188
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267178AbSKSSn7>; Tue, 19 Nov 2002 13:43:59 -0500
Date: Tue, 19 Nov 2002 10:50:41 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Patrick Mansfield <patmans@us.ibm.com>, Douglas Gilbert <dougg@torque.net>,
       "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
In-Reply-To: <3DDA8746.3010409@pobox.com>
Message-ID: <Pine.LNX.4.10.10211191049230.1342-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Jeff Garzik wrote:

> Patrick Mansfield wrote:
> 
> > I don't see why we need the #define, or is that another patch?
> 
> 
> 
> The define exists for the same reason that HAVE_xxx exists in 
> include/linux/netdevice.h and other headers:  a feature test macro, so 
> code using this pointer can detect its presence or absence.  The world 
> of drivers is not all in the kernel tarball, ya know ;-)
> 
> But as I said, the macro is misnamed, it should be 
> HAVE_UPPER_PRIVATE_DATA or similar.
> 
> 	Jeff

Hey Jeff!

Works for me, has each HBA has the need to reserve local structs and not
pollute the basic kernel w/ bloat!

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

