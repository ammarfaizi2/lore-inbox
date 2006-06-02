Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWFBVc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWFBVc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWFBVc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:32:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:36739 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750931AbWFBVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:32:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=tJ4HjF05zsEZgpo7yvTxX7opCfg3ylHxIn3SdfE336mEpcSR4DuI88Uz9HN5QoUfvzut2VL1j4iHrcTjjpKcNshNUrAtZBlGVERP1nXXa5xoAbGAEDSxiMpjqMHE9Q27BMInlogISi5Y3ZxjwUM0xfij/NKwOrjBOXMIw0CrTGo=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH] fix mem-leak in netfilter
Date: Fri, 2 Jun 2006 17:32:13 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Stephen Frost <sfrost@snowman.net>,
       Amin Azez <azez@ufomechanic.net>,
       "David S. Miller" <davem@davemloft.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <44643BFD.3040708@trash.net> <200606010943.31554.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <447EFF72.1050803@trash.net>
In-Reply-To: <447EFF72.1050803@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021732.14628.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 10:53, Patrick McHardy wrote:
> [CC-list trimmed]
> 
> Andrew James Wade wrote:
> > Hello Mr. McHardy,
> > 
> > The BUG below appears to be related to your ipt_recent rewrite. I
> > haven't tracked it down further yet. I've attached the (toy) firewall
> > script that's triggering the bug.
> 
> Yes, that was my fault. These two patches should fix it.
> 
> 
That fixed it, thanks.
