Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVFVXiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVFVXiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVFVXhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:37:48 -0400
Received: from mail.tyan.com ([66.122.195.4]:52484 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262557AbVFVXeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:34:05 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF96F9B@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Peter Buckingham <peter@pantasys.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Wed, 22 Jun 2005 16:37:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

do you mean the apic id lifting for opteron?

YH 

> -----Original Message-----
> From: Peter Buckingham [mailto:peter@pantasys.com] 
> Sent: Wednesday, June 22, 2005 4:32 PM
> To: Andi Kleen
> Cc: YhLu; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 with dual way dual core ck804 MB
> 
> Andi Kleen wrote:
> > There are two problems on AMD >8P. First the APIC 
> addressing doesn't 
> > work and needs to be done differently (I have a patch for 
> that in the 
> > final stages of testing). And then there is a mysterious scheduler 
> > deadlock problem in 2.6.12 that I haven't tracked down yet.
> > 2.6.11+patch works though.
> 
> okay, feel free to toss me the patch when your comfortable with it.
> 
> thanks,
> 
> peter
> 
