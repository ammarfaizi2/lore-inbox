Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313676AbSDHUDD>; Mon, 8 Apr 2002 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313680AbSDHUDB>; Mon, 8 Apr 2002 16:03:01 -0400
Received: from zero.tech9.net ([209.61.188.187]:52752 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313676AbSDHUCz>;
	Mon, 8 Apr 2002 16:02:55 -0400
Subject: Re: user-mode port 0.56-2.4.18-15
From: Robert Love <rml@tech9.net>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204082056.PAA03749@ccure.karaya.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 16:02:48 -0400
Message-Id: <1018296173.913.162.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 16:56, Jeff Dike wrote:

> Added SA_SAMPLE_RANDOM to the irq registration flags of some drivers.  This
> makes apps which read /dev/random work a lot better.  Randomness in UML is
> more problematic than on the host, but I chose a set of drivers whose
> interrupts shouldn't be too predictable.

If these drivers truly are sufficient candidates for feeding
/dev/random, perhaps you could pull these bits and submit them to Linus
and Marcelo?

I for one think this is a good idea.

	Robert Love


