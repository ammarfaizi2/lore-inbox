Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286710AbRL1DUe>; Thu, 27 Dec 2001 22:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286711AbRL1DUY>; Thu, 27 Dec 2001 22:20:24 -0500
Received: from dsl-213-023-039-026.arcor-ip.net ([213.23.39.26]:57095 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286710AbRL1DUM>;
	Thu, 27 Dec 2001 22:20:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Date: Fri, 28 Dec 2001 04:23:54 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011223174608.A25335@thyrsus.com> <E16JTce-0000cp-00@starship.berlin> <20011227112431.GA1582@msp-150.man.olsztyn.pl>
In-Reply-To: <20011227112431.GA1582@msp-150.man.olsztyn.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Jnci-000080-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 27, 2001 12:24 pm, Dominik Mierzejewski wrote:
> On Thursday, 27 December 2001, Daniel Phillips wrote:
> > Kilo, as in memory -> 1024
> > Kilo, as in distance or weight -> 1,000
> > 
> > Difficult?
> > 
> > /me wonders when the kibblebytes thread is going to end
> 
> /me wonders when people will learn to read more carefully
> (no offense intended) :-)
> 
> If you look at my post more closely, you'll see I used `kB' (that's small
> k and capital B) for decimal kilobyte. I would never suggest using `KB'
> (that's capital K and capital B) for it. I do agree that `KB' is 
> traditionally used for binary kilobytes, but what about MB, GB and so on? 
> These _are_ ambiguous. I am in favour of using Ki, Mi and Gi for binary 
> quantities.

So would you be happy with kB -> 1,000 bytes, and KB -> 1024 bytes?  Likewise
mB for 1,000,000 bytes and MB for 1048576 bytes?

Look, there's some precedent for it here:

   http://www.unc.edu/~rowlett/units/dictK.html
   "K - an informal abbreviation for one thousand used in expressions where 
   the unit is understood, such as "10K run" (10 kilometers) or "700K disk" 
   (700 kilobytes or kibibytes). Note that "K" is also the symbol for the 
   kelvin (see below). Also note that the symbol for the metric prefix kilo- 
   (1000) is actually k-, not K-."

If you believe that, then we don't have a problem, we never did:

  kB -> 1,000 bytes
  KB -> 1024 bytes

So, KiB is a silly fix for a problem that doesn't exist.  Let's not have that 
silliness creeping into our documentation, making it look silly too.

--
Daniel
