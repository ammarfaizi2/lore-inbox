Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUGGGs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUGGGs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGGGs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:48:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264919AbUGGGs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:48:58 -0400
Date: Wed, 7 Jul 2004 07:48:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707064857.GF12308@parcelfarce.linux.theplanet.co.uk>
References: <1089165901.4373.175.camel@orca.madrabbit.org> <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:55:01AM -0300, Alexandre Oliva wrote:
> On Jul  6, 2004, Ray Lee <ray-lk@madrabbit.org> wrote:
> 
> > Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.
> 
> Assuming ints are 32-bits wide.

ITYM "at least 32-bits wide".

>  They don't have to be.  They could be
> as narrow as 16 bits, in which case

... you would have no fscking chance to build Linux kernel on such platform
for $BIGNUM reasons.
