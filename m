Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbQLVTws>; Fri, 22 Dec 2000 14:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQLVTwi>; Fri, 22 Dec 2000 14:52:38 -0500
Received: from Cantor.suse.de ([194.112.123.193]:21003 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131066AbQLVTw1>;
	Fri, 22 Dec 2000 14:52:27 -0500
Date: Fri, 22 Dec 2000 20:21:37 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222202137.A27844@gruyere.muc.suse.de>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org> <20001222113530.A14479@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001222113530.A14479@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Dec 22, 2000 at 11:35:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 11:35:30AM -0700, Jeff V. Merkey wrote:
> The real question is how to guarantee that these pages will be contiguous
> in memory.  The slab allocator may also work, but I think there are size
> constraints on how much I can get in one pass.

You cannot guarantee it after the system has left bootup stage. That's the
whole reason why bigphysarea exists.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
