Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281034AbRKGWh1>; Wed, 7 Nov 2001 17:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281030AbRKGWhS>; Wed, 7 Nov 2001 17:37:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:24080 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281024AbRKGWhG>;
	Wed, 7 Nov 2001 17:37:06 -0500
Subject: Re: AGPGART build problem in 2.4.14
From: Robert Love <rml@tech9.net>
To: Brandon Barker <bebarker@meginc.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111070323.WAA01534@sioux.meginc.com>
In-Reply-To: <200111070323.WAA01534@sioux.meginc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 07 Nov 2001 17:37:07 -0500
Message-Id: <1005172631.939.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 22:27, Brandon Barker wrote:
> The following problem occured while building linux 2.4.14 while trying to 
> make the agpgart driver (system is Intel/Redhat 7.2):

> If this problem is resolved please tell me, I'd be very appreciative.
> Brandon Barker

I can't duplicate the problem.  Have you tried recompiling since the
post?

Do a full clean `make oldconfig dep clean bzImage'

I can't figure why your flush isn't being defined, since it should be as
long as __i386__ is defined.

	Robert Love

