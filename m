Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310364AbSCGPj6>; Thu, 7 Mar 2002 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310366AbSCGPjx>; Thu, 7 Mar 2002 10:39:53 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:50612 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310364AbSCGPjr>;
	Thu, 7 Mar 2002 10:39:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Arch option to touch newly allocated pages
Date: Thu, 7 Mar 2002 16:34:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16iz6l-0002St-00@the-village.bc.nu>
In-Reply-To: <E16iz6l-0002St-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16izuL-000395-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 03:43 pm, Alan Cox wrote:
> And if we are OOM - we want to return NULL

Oh, right, it lets an allocator that didn't 100% need the page use a
fallback strategy, but for that we probably want a different interface
anyway, such as a GFP flag that says 'fail if this looks hard to get'.

-- 
Daniel
