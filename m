Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVBQGYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVBQGYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVBQGYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:24:00 -0500
Received: from mail.tyan.com ([66.122.195.4]:30739 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262230AbVBQGXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:23:46 -0500
Message-ID: <3174569B9743D511922F00A0C94314230808598A@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: node_to_cpumask  x86_64 broken
Date: Wed, 16 Feb 2005 22:37:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. should not use prink(ERR.... 

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Wednesday, February 16, 2005 10:22 PM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: node_to_cpumask x86_64 broken
> 
> On Wed, Feb 16, 2005 at 10:30:51PM -0800, YhLu wrote:
> > forget about it. I found the reason:  I only put node 0 has 
> RAM installed.
> 
> There is some problem with this code - it complains on a few machines.
> However it's relatively harmless when this happens, so I 
> haven't looked it yet. Should perhaps take out the printk.
> 
> -Andi
> 
