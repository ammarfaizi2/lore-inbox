Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUDTPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDTPTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTPTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:19:23 -0400
Received: from ida.rowland.org ([192.131.102.52]:15364 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262873AbUDTPTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:19:13 -0400
Date: Tue, 20 Apr 2004 11:19:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] USB mass storage device has SCSI i/o errors,
 kernel > 2.6.3
In-Reply-To: <DDF9139AA996D511BBDE00508BB927450A208BF0@nbhexch1.nbnz.co.nz>
Message-ID: <Pine.LNX.4.44L0.0404201117080.1056-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Roberts-Thomson, James wrote:

> Hi,
> 
> I have noticed an issue with writing to a USB mass storage device, which is
> a flash-rom-based mp3 player.
> 
> I first noticed this issue with kernel 2.6.5 and the -mm6 patchset.  I have
> verified that this issue still occurs with 2.6.6-rc1-bk4, as requested by
> Andrew Morton.  This error was never noticed in any kernel v2.6.3 or less;
> including v2.4.x kernels; both stock and with -wolk and -mm patchsets.

It's possible that this is caused by a recently-introduced bug in the UHCI
driver.  A patch was posted yesterday:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108238832020721&q=raw

Alan Stern


