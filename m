Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbREYIS3>; Fri, 25 May 2001 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263637AbREYIST>; Fri, 25 May 2001 04:18:19 -0400
Received: from ns.suse.de ([213.95.15.193]:10257 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263630AbREYISI>;
	Fri, 25 May 2001 04:18:08 -0400
Date: Fri, 25 May 2001 10:17:07 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525101707.B26038@gruyere.muc.suse.de>
In-Reply-To: <20010525013303.A21810@gruyere.muc.suse.de> <23182.990768020@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23182.990768020@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 03:20:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 03:20:20PM +1000, Keith Owens wrote:
> ftp://ftp.ocs.com.au/pub/kernel.stack.gz.  ix86 specific, probably gcc
> specific and it only picks up code that you compile.  The Stanford
> checker is much better.

I have no complete understanding of the stanford checker, but I was assuming
that it was a hacked version of gcc. If yes it has to use the preprocessor
and also will only catch stuff you compile. I don't see how you can do 
meaningfull lint like checks without a preprocessor ;)

-Andi
