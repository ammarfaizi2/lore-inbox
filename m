Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTAHBMx>; Tue, 7 Jan 2003 20:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTAHBMx>; Tue, 7 Jan 2003 20:12:53 -0500
Received: from are.twiddle.net ([64.81.246.98]:27265 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267617AbTAHBMx>;
	Tue, 7 Jan 2003 20:12:53 -0500
Date: Tue, 7 Jan 2003 17:21:28 -0800
From: Richard Henderson <rth@twiddle.net>
To: Zack Weinberg <zack@codesourcery.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030107172128.A9592@twiddle.net>
Mail-Followup-To: Zack Weinberg <zack@codesourcery.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <87isx2dktj.fsf@egil.codesourcery.com> <20030107111905.GA949@bjl1.asuk.net> <87of6s3gm3.fsf@egil.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87of6s3gm3.fsf@egil.codesourcery.com>; from zack@codesourcery.com on Tue, Jan 07, 2003 at 11:27:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 11:27:32AM -0800, Zack Weinberg wrote:
> > It explicitly checks for the opcode sequences 0x58b877000000cd80 and
> > 0xb8ad000000cd80 in order to unwind exception frames around a
> > handled signal.  Ugly, isn't it?
> 
> We're open to better ideas ...

Something like having dwarf2 unwind information for the
vsyscall page on the page as well?


r~
