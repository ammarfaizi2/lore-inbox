Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbSLDSBX>; Wed, 4 Dec 2002 13:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSLDSBX>; Wed, 4 Dec 2002 13:01:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63421 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266999AbSLDSBW>; Wed, 4 Dec 2002 13:01:22 -0500
Date: Wed, 4 Dec 2002 10:10:16 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
Message-ID: <20021204181016.GB1584@beaverton.ibm.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
	linux-kernel@vger.kernel.org
References: <200212041709.gB4H9LA02808@localhost.localdomain> <20021204175602.GC27780@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204175602.GC27780@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH [greg@kroah.com] wrote:
> On Wed, Dec 04, 2002 at 11:09:21AM -0600, James Bottomley wrote:
> > There are certain bus types (notably MCA and parisc internal ones) that like 
> > to do generic houskeeping operations (claim slots, claim uniform resources 
> > etc.) when drivers are attached to devices.
> 
> But doesn't the bus specific core know when drivers are attached, as it
> was told to register or unregister a specific driver?  So I don't see
> why this is really needed.

The change is when a device is bound to a driver (i.e. when attach /
detach is called bus.c ).

-andmike
--
Michael Anderson
andmike@us.ibm.com

