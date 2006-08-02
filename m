Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWHBMgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWHBMgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWHBMgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:36:11 -0400
Received: from front1.netvisao.pt ([213.228.128.56]:695 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP id S1750840AbWHBMgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:36:11 -0400
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Organization: ISR/IST
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: kernel hangs when trying to remove a bridge
Date: Wed, 2 Aug 2006 12:30:44 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200607291642.05046.yoda@isr.ist.utl.pt> <20060731112220.0c14d1bc@localhost.localdomain>
In-Reply-To: <20060731112220.0c14d1bc@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021230.44794.yoda@isr.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 19:22, Stephen Hemminger wrote:
> There was a bug in the VLAN code that did that, not sure which version
> it was fixed in.
>
> Do you have IPV6 installed (as a module)?
> In some kernel versions, IPV6 has a problem with device ref counting, and
> leaves a dangling reference.

Yes, I have ipv6 working (dual-stack) and as a module.

The problem I reported was not found in earlier kernels, so it is all working 
fine now.

Cheers,

Rodrigo

-- 
Rodrigo Ventura
ISR/IST
