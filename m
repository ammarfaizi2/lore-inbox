Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSALCxX>; Fri, 11 Jan 2002 21:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbSALCxM>; Fri, 11 Jan 2002 21:53:12 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:29963 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S282978AbSALCxF>;
	Fri, 11 Jan 2002 21:53:05 -0500
Date: Fri, 11 Jan 2002 19:50:18 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020111195018.A2008@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1010781207.819.27.camel@phantasy>; from rml@tech9.net on Fri, Jan 11, 2002 at 03:33:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> The preemptible kernel plus the spinlock cleanup could really take us
> far.  Having locked at a lot of the long-held locks in the kernel, I am
> confident at least reasonable progress could be made.
> 
> Beyond that, yah, we need a better locking construct.  Priority
> inversion could be solved with a priority-inheriting mutex, which we can
> tackle if and when we want to go that route.  Not now.

Backing the car up to the edge of the cliff really gives us
good results. Beyond that, we could jump off the cliff
if we want to go that route.
Preempt leads to inheritance and inheritance leads to disaster.


All the numbers I've seen show Morton's low latency just works better. Are
there other numbers I should look at.


