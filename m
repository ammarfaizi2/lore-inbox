Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310482AbSCBXtt>; Sat, 2 Mar 2002 18:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310483AbSCBXtj>; Sat, 2 Mar 2002 18:49:39 -0500
Received: from chmls06.ne.ipsvc.net ([24.147.1.144]:46031 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S310482AbSCBXt3>; Sat, 2 Mar 2002 18:49:29 -0500
Date: Sat, 2 Mar 2002 18:31:03 -0500
To: erich@uruk.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Julian Anastasov <ja@ssi.bg>,
        Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug )
Message-ID: <20020302233103.GA3018@pimlott.ne.mediaone.net>
Mail-Followup-To: erich@uruk.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Julian Anastasov <ja@ssi.bg>, Szekeres Bela <szekeres@lhsystems.hu>,
	Daniel Gryniewicz <dang@fprintf.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16hG1r-0008Kh-00@the-village.bc.nu> <E16hGAW-0000Rw-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hGAW-0000Rw-00@trillium-hollow.org>
User-Agent: Mutt/1.3.27i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 12:31:48PM -0800, erich@uruk.org wrote:
> My general contention is that the system should, by default, behave as
> non-experts would expect, but this might be a point where we can't
> agree.
> 
> It is, unfortunately, the cardinal rule when designing any usable
> interfaces.  I reference Donald Norman's "The Design of Everyday
> Things".  But I digress.

I must agree with Alan.  Low level technical interfaces should
behave according to standards, and should follow a consistent logic
understood by experts in the field (even if it is difficult for the
beginner).  If people try to push "usability" (and I'm as much a fan
of that book as you) onto kernel interfaces, we'll wade into a swamp
and never get out.

Such interfaces need not be exposed to ordinary users.  Indeed, by
keeping the low-level layer simple and orthogonal, it becomes easier
to build multiple user-facing layers (for different purposes, or for
comparison at the same purpose).  I think this principle is much
more powerful than the one you advance.

Andrew
