Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRKVNFw>; Thu, 22 Nov 2001 08:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRKVNFn>; Thu, 22 Nov 2001 08:05:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:20102 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S278690AbRKVNFd>;
	Thu, 22 Nov 2001 08:05:33 -0500
Date: Thu, 22 Nov 2001 14:05:17 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions
Message-ID: <20011122140517.A20826@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <hch@ns.caldera.de> <200111221230.fAMCU6QJ007258@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111221230.fAMCU6QJ007258@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Thu, Nov 22, 2001 at 09:30:06AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 09:30:06AM -0300, Horst von Brand wrote:
> > Nope, it's fine to remove it.  Input is racy all over the place and the list
> > are modified somewhere else without any locking anyways.
> 
> "It is broken anyway, breaking it some more makes no difference"!?

Wether you lock access to shared data at one or zero points doesn't matter,
so it's not breaking it more.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
