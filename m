Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277201AbRJDSwu>; Thu, 4 Oct 2001 14:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277207AbRJDSwl>; Thu, 4 Oct 2001 14:52:41 -0400
Received: from are.twiddle.net ([64.81.246.98]:31904 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277201AbRJDSwb>;
	Thu, 4 Oct 2001 14:52:31 -0400
Date: Thu, 4 Oct 2001 11:52:04 -0700
From: Richard Henderson <rth@twiddle.net>
To: Andreas Schwab <schwab@suse.de>
Cc: James Antill <james@and.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
Message-ID: <20011004115204.A11463@twiddle.net>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	James Antill <james@and.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel> <E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel> <9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel> <oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de> <jeelp4rbtf.fsf@sykes.suse.de> <20010918143827.A16003@gruyere.muc.suse.de> <nn3d59qzho.fsf@code.and.org> <jezo7gu78f.fsf@sykes.suse.de> <nnvgi4prod.fsf@code.and.org> <jeofnwsinb.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <jeofnwsinb.fsf@sykes.suse.de>; from schwab@suse.de on Thu, Sep 27, 2001 at 06:28:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 06:28:08PM +0200, Andreas Schwab wrote:
> You're right, seems like __builtin_expect is really only defined for pure
> boolean values.

I think the documentation mentions the current deficiency in that area.
It is _supposed_ to be defined for all integral and pointer types, but
that is hard with the current built-in infrastructure in the C front end.


r~
