Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTH1C4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 22:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTH1C4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 22:56:55 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:5134 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263426AbTH1C4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 22:56:54 -0400
Date: Thu, 28 Aug 2003 12:56:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Poor IPSec performance with 2.6 kernels
In-Reply-To: <1062038303.2947.11.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Mutt.LNX.4.44.0308281254180.18344-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2003, Tom Sightler wrote:

> My Internet connection is a DSL circuit that typically delivers about
> 150KB/s.  When I connect with SuperFreeS/WAN my VPN throughput is quite
> good, averaging about 125KB/s (this seems about reasonable with
> overhead) but when making the identical connection with racoon and the
> 2.6 kernel I can only achieve 50KB/s.  I've been unable to come up with
> any reason why this would be the case.
> 
> Any hints would be appreciated.

I think SFS uses assembly crypto algorithms where possible, which would 
account for roughly 2x performance increase.


- James
-- 
James Morris
<jmorris@intercode.com.au>

