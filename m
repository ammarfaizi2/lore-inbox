Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSGJUoZ>; Wed, 10 Jul 2002 16:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGJUoY>; Wed, 10 Jul 2002 16:44:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34297 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317616AbSGJUoX>; Wed, 10 Jul 2002 16:44:23 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cort Dougan <cort@fsmlabs.com>, Ville Herva <vherva@niksula.hut.fi>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17SOg4-0007oM-00@the-village.bc.nu>
References: <E17SOg4-0007oM-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Jul 2002 13:46:26 -0700
Message-Id: <1026333986.1178.98.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 14:07, Alan Cox wrote:

> > Why was the rate incremented to maintain interactive performance?  Wasn't
> > that the whole idea of the pre-empt work?  Does the burden of pre-empt
> > actually require this?
> 
> Bizarrely in many cases it increases throughput

I can attest to this.  We see the same thing with the preemptible kernel
(throughput increases on certain workloads).

My guess would be the better process response applies the same to
throughput: sooner to wake up, sooner to run, sooner to be done.

	Robert Love

