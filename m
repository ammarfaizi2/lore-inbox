Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVFUWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVFUWkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVFUWjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:39:20 -0400
Received: from mail.tyan.com ([66.122.195.4]:19205 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262382AbVFUWOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:14:55 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A40469D@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Tue, 21 Jun 2005 15:17:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just  after starting core0 of node 1.

YH

Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81013ff89f58
Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/2 rip 6000 rsp ffff81023ff11f58
Initializing CPU#2
masked ExtINT on CPU#2 --------------------------------------------here

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Tuesday, June 21, 2005 3:12 PM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 with dual way dual core ck804 MB
> 
> On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> > andi,
> > 
> > for the dual way dual core Opteron ck804 MB, the 2.6.12 
> still has the 
> > timing problem, I  still need to add one printk in 
> amd_detec_cmp after 
> > the phys_proc_id is setup.
> 
> It works for me on several dual core systems, except on a 
> very big one that seems to run into a scheduler problem.
> 
> Where exactly does yours lock up? 
> 
> -Andi
> 
