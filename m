Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVIUP0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVIUP0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVIUP0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:26:36 -0400
Received: from amdext4.amd.com ([163.181.251.6]:44455 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751073AbVIUP0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:26:35 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that
 dualcore cpus have synced TSCs
Date: Wed, 21 Sep 2005 10:46:25 -0500
User-Agent: KMail/1.8
cc: "Daniel Jacobowitz" <dan@debian.org>, "john stultz" <johnstul@us.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
 <200509211015.09356.raybry@mpdtxmail.amd.com>
 <20050921150404.GD12810@verdi.suse.de>
In-Reply-To: <20050921150404.GD12810@verdi.suse.de>
MIME-Version: 1.0
Message-ID: <200509211046.25555.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F2FA41A28G1805423-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 10:04, Andi Kleen wrote:

>
> We handle this, but single socket dual core was special cased because
> I was told previously it should be ok.
>
> -Andi

AFAIK there is a processor state bit that enables/disables this behavior.
Apparently some BIOS's are setting this one way for desktop systems and the 
other way for servers.   If it is thought to be important I can track that 
down and see if it can be externally documented.  (It may actually be in the 
bios and kernel developer guide...)

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

