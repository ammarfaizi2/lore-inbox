Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSLDTWH>; Wed, 4 Dec 2002 14:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSLDTWH>; Wed, 4 Dec 2002 14:22:07 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:27040 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267030AbSLDTWG>; Wed, 4 Dec 2002 14:22:06 -0500
Date: Wed, 4 Dec 2002 20:29:20 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
Message-ID: <20021204192919.GA3969@neljae>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com> <1038935401.994.9.camel@phantasy> <20021204131024.GA3428@neljae> <1039018361.1505.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039018361.1505.7.camel@phantasy>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:12:42AM -0500, Robert Love wrote:
> There are no flushing parameters in 2.5, and this is a patch for 2.5.

I'm aware of that.  And I'm not opposed to the patch, but I'm opposed to
the notion that sys_bdflush as a whole has been useless for ages.  E.g.
noflushd[1] on 2.4 happily calls it every five seconds.  Count this as a
vote for rate limiting the message, for the benefit of folks switching
between 2.4 and 2.5.

Regards,

Daniel.

[1] Admittedly a bad example as it won't start on 2.5 anyway, but there
    might be similar codes around.
