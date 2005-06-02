Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFBVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFBVwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVFBVt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:49:58 -0400
Received: from mail.tyan.com ([66.122.195.4]:7179 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261356AbVFBVbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:31:50 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A40399E@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	 e dual way
Date: Thu, 2 Jun 2005 14:33:06 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So siblings should be in one core...? that make sense....

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Thursday, June 02, 2005 11:52 AM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron 
> MB/with dual cor e dual way
> 
> On Wed, Jun 01, 2005 at 08:26:00PM -0700, YhLu wrote:
> > Brought up 4 CPUs
> >     CPU 0, cpu_sibling_map[0]= 1 
> >     CPU 0, cpu_core_map[0]= 3 
> >     CPU 1, cpu_sibling_map[1]= 2 
> >     CPU 1, cpu_core_map[1]= 3 
> >     CPU 2, cpu_sibling_map[2]= 4 
> >     CPU 2, cpu_core_map[2]= c 
> >     CPU 3, cpu_sibling_map[3]= 8 
> >     CPU 3, cpu_core_map[3]= c
> > are the cpu_sibling_map[] right? 
> 
> Yes it is correct. A CPU is always a sibling of itself.
> 
> -Andi
> 
