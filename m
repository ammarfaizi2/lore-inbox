Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286269AbRLTPSb>; Thu, 20 Dec 2001 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286274AbRLTPSW>; Thu, 20 Dec 2001 10:18:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11531 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286269AbRLTPSK>; Thu, 20 Dec 2001 10:18:10 -0500
Date: Thu, 20 Dec 2001 15:11:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - prefetchable memory regions
Message-ID: <20011220151139.B30517@flint.arm.linux.org.uk>
In-Reply-To: <20011218235035.P13126@flint.arm.linux.org.uk> <20011220161331.A5330@jurassic.park.msu.ru> <20011220133618.A30517@flint.arm.linux.org.uk> <20011220175926.A6468@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011220175926.A6468@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Dec 20, 2001 at 05:59:26PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 05:59:26PM +0300, Ivan Kokshaysky wrote:
> Just fine, if your root_bus->resource[2] is not NULL and initialized
> properly. If it's too small to hold all prefetchable resources,
> the rest will be allocated in the non-prefetch memory region.

Which is also what my patch does.

Ok, I'll wait until you put out your patch before further comment.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

