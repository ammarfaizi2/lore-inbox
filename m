Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSCCQ5I>; Sun, 3 Mar 2002 11:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSCCQ47>; Sun, 3 Mar 2002 11:56:59 -0500
Received: from parser.nl ([195.241.139.174]:32508 "EHLO transit.parser.nl")
	by vger.kernel.org with ESMTP id <S287596AbSCCQ44>;
	Sun, 3 Mar 2002 11:56:56 -0500
Subject: Re: hard drive UDMA weirdness
From: Michiel van de Garde <garde@benben.com>
To: David Madore <david.madore@ens.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020303174014.A3393@clipper.ens.fr>
In-Reply-To: <20020303174014.A3393@clipper.ens.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 03 Mar 2002 17:54:34 +0100
Message-Id: <1015174515.431.11.camel@flaptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-03 at 17:40, David Madore wrote:
> Hi.
> 
> [Summary: the very same hard drive works fine in UDMA-33 mode on one
> computer and not on another, whereas they run the same version of
> Linux and have near-identical motherboards and BIOS versions.]
> 
> [Detailed hardware configuration is given at bottom.]

<snip>
Since you didn't mention it I assume you haven't tested the ide cables. 

Did you try changing the cables?

I myself have been experiencing problems that were related to a faulty
ide cable which looked fine on the surface. The kernel will try
resetting ideX continuously causing (in my case) filesystem corruption
in the end... It's not a pretty sight.

Michiel van de Garde
Parser Consultancy
w: www.parser.nl
e: garde@parser.nl

-- 
"I do not require that my work be confirmed by observation. It is enough
that it fit well enough that everyone believes it to be right."
- Stephen Hawking

