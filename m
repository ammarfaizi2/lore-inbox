Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHQArZ>; Thu, 16 Aug 2001 20:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269226AbRHQArQ>; Thu, 16 Aug 2001 20:47:16 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:7604 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269212AbRHQArI>;
	Thu, 16 Aug 2001 20:47:08 -0400
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
From: Robert Love <rml@tech9.net>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr>
In-Reply-To: <997936615.921.22.camel@phantasy>
	<20010816105010.A10595@se1.cogenit.fr> <997973433.684.3.camel@phantasy> 
	<20010816190255.A17095@se1.cogenit.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 20:47:48 -0400
Message-Id: <998009276.660.69.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 19:02:55 +0200, Francois Romieu wrote:
> Robert Love <rml@tech9.net> :
> > What is experimental about it?
> 
> The implicit-and-should-be-debated-in-2.5 assumption that the entropy 
> estimate still makes sense ?

then mark the entropy generator experimental if you believe that.  its
irrelevant here.

this is just taking a behavior that is inconsistent (do NICs enable
SA_SAMPLE_RANDOM), making it consistent (SA_SAMPLE_NET_RANDOM), and
making it configurable.  Nothing is experimental.  This does not change
things; it makes things configurable.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

