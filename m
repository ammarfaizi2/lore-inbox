Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVBKVUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVBKVUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVBKVUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:20:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22523 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262349AbVBKVTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:19:46 -0500
Subject: Re: [PATCH] tg3: capacitive coupling detection fix
From: john stultz <johnstul@us.ibm.com>
To: Michael Chan <mchan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       lkml <linux-kernel@vger.kernel.org>, Chris McDermott <lcm@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3D93@NT-IRVA-0741.brcm.ad.broadcom.com>
References: <B1508D50A0692F42B217C22C02D84972020F3D93@NT-IRVA-0741.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 13:19:37 -0800
Message-Id: <1108156778.11683.212.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 12:44 -0800, Michael Chan wrote:
> This patch fixes the problem reported in:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110798711911645&w=2
> 
> 
> The 5700 link problem was caused by reading uninitialized values in sram and
> causing capacitive coupling mode to be enabled by mistake. This patch fixes
> the problem by properly validating the sram contents.

Verified as working on the x440 I was seeing the trouble with.

Thanks!
-john

