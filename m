Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYK6v>; Thu, 25 Jan 2001 05:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRAYK6l>; Thu, 25 Jan 2001 05:58:41 -0500
Received: from p3EE3C7D3.dip.t-dialin.net ([62.227.199.211]:13572 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129444AbRAYK6g>; Thu, 25 Jan 2001 05:58:36 -0500
Date: Thu, 25 Jan 2001 11:58:28 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010125115827.A1483@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com> <200101242003.XAA21040@ms2.inr.ac.ru> <20010124215634.A2992@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124215634.A2992@gruyere.muc.suse.de>; from ak@suse.de on Wed, Jan 24, 2001 at 21:56:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Andi Kleen wrote:

> It's mostly for security to make it more difficult to nuke connections
> without knowing the sequence number.
> 
> Remember RFC is from a very different internet with much less DoS attacks.

If you're deliberately breaking compatibility by violating the specs,
you're making your own DoS if your machines can't chat to each other. If
you insist on breaking the RFC, make a sysctl for this behaviour that
defaults to "off".

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
