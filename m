Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269287AbRHQArZ>; Thu, 16 Aug 2001 20:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRHQArQ>; Thu, 16 Aug 2001 20:47:16 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:6324 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269226AbRHQArA>;
	Thu, 16 Aug 2001 20:47:00 -0400
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
From: Robert Love <rml@tech9.net>
To: stimits@idcomm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B7C2AED.F8882B5A@idcomm.com>
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr>
	<212453020.997993720@[169.254.45.213]>  <3B7C2AED.F8882B5A@idcomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 20:47:35 -0400
Message-Id: <998009263.660.65.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 14:19:57 -0600, D. Stimits wrote:
> It would be interesting if an option were possible for entropy pool via
> loopback traffic.

is that humor? :)

it can certainly generate a large amount of entropy if you let it.

but the general mechanism for grabbing entropy from char/net devices is
measuring values from their interrupt timings.  this is done via a flag
value in request_irq.

loopback has no interrupts thus no request_irq

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

