Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272497AbRH3Vr1>; Thu, 30 Aug 2001 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272498AbRH3VrJ>; Thu, 30 Aug 2001 17:47:09 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:21695 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S272493AbRH3Vqs>;
	Thu, 30 Aug 2001 17:46:48 -0400
Date: Thu, 30 Aug 2001 23:47:00 +0200
From: David Weinehall <tao@acc.umu.se>
To: Graham Murray <graham@barnowl.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010830234659.B14715@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com> <20010830165447Z16272-32385+540@humbolt.nl.linux.org> <m266b51c5c.fsf@barnowl.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <m266b51c5c.fsf@barnowl.demon.co.uk>; from graham@barnowl.demon.co.uk on Thu, Aug 30, 2001 at 09:16:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 09:16:47PM +0000, Graham Murray wrote:
> Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> > More than anything, it shows that education is needed, not macro patch-ups.
> > We have exactly the same issues with < and >, should we introduce 
> > three-argument macros to replace them?
> 
> Would it not have been much more "obvious" if the rules for
> unsigned/signed integer comparisons (irrespective of the widths
> involved) were
> 
> 1) If the signed element is negative then it is always less than the
>    unsigned element.
> 
> 2) If the unsigned element is greater than then maximum positive value
>    expressible by the signed one then it is always greater.
> 
> 3) Only if both values are positive and within the range of the
>    smaller element are the actual values compared. 

Possibly, but changing the C specification is not really an option here...


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
