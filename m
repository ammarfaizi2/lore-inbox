Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRKTXP3>; Tue, 20 Nov 2001 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281485AbRKTXPU>; Tue, 20 Nov 2001 18:15:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:38599 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S281483AbRKTXPF>;
	Tue, 20 Nov 2001 18:15:05 -0500
Date: Tue, 20 Nov 2001 15:14:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jan Hubicka <jh@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: i386 flags register clober in inline assembly
Message-ID: <20011120151455.A26731@twiddle.net>
Mail-Followup-To: Jan Hubicka <jh@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011118020957.A10674@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com> <20011120003338.A24717@twiddle.net> <20011120140059.E16297@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120140059.E16297@atrey.karlin.mff.cuni.cz>; from jh@suse.cz on Tue, Nov 20, 2001 at 02:00:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 02:00:59PM +0100, Jan Hubicka wrote:
> True. Only obstackle I see is how to make visible that the flags
> are set by the asm statement.

Well, that's the Z constraint.  Trickier is getting the backend
to _not_ add the clobber in that instance.


r~
