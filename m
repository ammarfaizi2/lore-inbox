Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277698AbRJNVGe>; Sun, 14 Oct 2001 17:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277790AbRJNVGY>; Sun, 14 Oct 2001 17:06:24 -0400
Received: from colin.muc.de ([193.149.48.1]:22534 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S277698AbRJNVGP>;
	Sun, 14 Oct 2001 17:06:15 -0400
Message-ID: <20011014230709.47894@colin.muc.de>
Date: Sun, 14 Oct 2001 23:07:09 +0200
From: Andi Kleen <ak@muc.de>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Andi Kleen <ak@muc.de>, Tommy Faasen <tommy@vuurwerk.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP processor rework help needed
In-Reply-To: <k2wv1yhsh4.fsf@zero.aec.at> <Pine.LNX.4.10.10110141349510.31660-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.10.10110141349510.31660-100000@innerfire.net>; from Gerhard Mack on Sun, Oct 14, 2001 at 10:50:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 10:50:50PM +0200, Gerhard Mack wrote:
> This may sound like a dumb question but wouldn't simply swapping the CPUs
> have the same affect?

In theory yes, assuming the determination of the boot cpu is fully
deterministic. the spec says it is the one with the lowest apic number; but
who knows if that is true in every weird board.

-Andi

