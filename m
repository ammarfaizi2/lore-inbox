Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSGJUXE>; Wed, 10 Jul 2002 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSGJUXD>; Wed, 10 Jul 2002 16:23:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6643 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317603AbSGJUXD>; Wed, 10 Jul 2002 16:23:03 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
From: Robert Love <rml@tech9.net>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020710142005.U762@host110.fsmlabs.com>
References: <3D2B89AC.25661.91896FEB@localhost>
	<1026323661.1178.73.camel@sinai> <20020710191824.GT1548@niksula.cs.hut.fi>
	<1026331418.1244.82.camel@sinai>  <20020710142005.U762@host110.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Jul 2002 13:25:38 -0700
Message-Id: <1026332738.1244.86.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 13:20, Cort Dougan wrote:

> Why was the rate incremented to maintain interactive performance?  Wasn't
> that the whole idea of the pre-empt work?  Does the burden of pre-empt
> actually require this?

I did not say it was increased to improve interactivity response - and
it certainly has little or nothing to do with kernel preemption being
merged.

I suspect a big benefit would be poll/select performance.  I think this
is why RedHat increased HZ in their kernels.

You would have to ask Linus exactly what his intentions were.

> It seems that the added inefficiency of these extra interrupts is going to
> drag performance down.

	Robert Love

