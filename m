Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUBDWWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUBDWWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:22:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266651AbUBDWWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:22:25 -0500
Date: Wed, 4 Feb 2004 22:22:23 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Juergen Rose <rose@rz.uni-potsdam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: imm.ko and linux-2.6.1 or linux-2.6.2
Message-ID: <20040204222223.GC21151@parcelfarce.linux.theplanet.co.uk>
References: <1075929081.30698.76.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075929081.30698.76.camel@moen.bioinf.mdc-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 10:11:21PM +0100, Juergen Rose wrote:
> Hi,
> 
> I am very satisfied with the imm driver, when I am using it with
> linux-2.4.*, everything is working fine. But using imm.ko together with
> linux-2.6.1 or linux-2.6.2 I get:
>  
> imm: Version 2.05 (for Linux 2.4.0)
> imm: parport reports no devices.
> FATAL: Error inserting imm
> (/lib/modules/2.6.2/kernel/drivers/scsi/imm.ko): No such device
> 
> if I perform 'modprobe imm'. I can't reach the email address in imm.c
> (<campbell@torque.net>... User unknown).  Do you have any hint for me?

Have you tried -mm?  There are both generic parport patches and patches
specifically for imm.c; it looks like generic parport problem, though.

BTW, have the parport code found any ports in the first place?  Boot
log would be useful...
