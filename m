Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266620AbRGJP5w>; Tue, 10 Jul 2001 11:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266629AbRGJP5q>; Tue, 10 Jul 2001 11:57:46 -0400
Received: from ns.caldera.de ([212.34.180.1]:25801 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266620AbRGJP53>;
	Tue, 10 Jul 2001 11:57:29 -0400
Date: Tue, 10 Jul 2001 17:57:08 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Randy.Dunlap" <rddunlap@osdlab.org>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010710175708.A18588@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, "Randy.Dunlap" <rddunlap@osdlab.org>,
	linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20010711022509.C31966@weta.f00f.org> <3B4B1E91.A7D75608@osdlab.org> <20010711035038.A32188@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711035038.A32188@weta.f00f.org>; from cw@f00f.org on Wed, Jul 11, 2001 at 03:50:38AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 03:50:38AM +1200, Chris Wedgwood wrote:
> On Tue, Jul 10, 2001 at 08:26:09AM -0700, Randy.Dunlap wrote:
> 
>     I have heard of some IBM/Sequent patches that modify the
>     logical vs. physical APIC addressing scheme to make 16-way
>     systems work.
> 
> The Unisys machine is actually four quad-CPU machines with shared
> memory, dynamically configurable and other neat stuff.

If it is the Unisys design I mean it is done rather different.
The design I saw has two central crossbars and attached either CPU
modules with a GTL+ bus and two CPUs after a L3 cache or a IO
Module with a few (IIRC 3) PCI busses.

-- 
Of course it doesn't work. We've performed a software upgrade.
