Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFBSzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFBSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFBSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:55:16 -0400
Received: from mail.tyan.com ([66.122.195.4]:58385 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261242AbVFBSzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:55:06 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A403970@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	 e dual way
Date: Thu, 2 Jun 2005 11:56:25 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really?,  smp_num_siblings is global variable and initially is set 1.

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Thursday, June 02, 2005 11:51 AM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron 
> MB/with dual cor e dual way
> 
> On Wed, Jun 01, 2005 at 08:16:35PM -0700, YhLu wrote:
> > andi,
> > 
> > in arch/x86_64/kernel/smboot.c, function detect_siblings(),
> > 
> > because smp_num_siblings is always =1,  so several lines 
> can be removed.
> 
> What do you mean? On intel systems with HyperThreading it is > 1.
