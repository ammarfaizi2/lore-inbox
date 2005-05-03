Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVECWYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVECWYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVECWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:24:18 -0400
Received: from animx.eu.org ([216.98.75.249]:39048 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261859AbVECWXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:23:55 -0400
Date: Tue, 3 May 2005 18:23:28 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Rick Warner <rick@microway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503222328.GE12199@animx.eu.org>
Mail-Followup-To: Rick Warner <rick@microway.com>,
	linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com> <20050503164012.GE11937@animx.eu.org> <200505031742.40554.rick@microway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505031742.40554.rick@microway.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Warner wrote:
> On Tuesday 03 May 2005 12:40 pm, Wakko Warner wrote:
> > Please keep me CCd

> As others have mentioned, bzImage seems to be a requirement now for x86.  
> However, zImage will not do any better for you.  I recall doing testing of 
> zImage vs bzImage a long time back, and the bzImage kernels were slightly 
> smaller than the zImage ones anyway.  I think you're going to be out of luck 
> trying to get your kernel that small.  A single floppy boot/root disk isn't 
> really possible with 2.6 kernels anymore.  Have you looked into pxe booting 
> instead?  I work at a cluster company and we do tons of pxe/network booting 
> stuff.

Not all machines are PXE capable.  The boot will be generally CDrom or USB
stick.  I wanted to continue to support our machines that are not capable of
booting from either of these (which all of these are not PXE capable)

I might beable to pull this off, I don't know yet.  If it wasn't for all the
modules I have placed in the initrd, I could.  (I could remove one of the
modules and it would fit just fine but I might actually need that module)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
