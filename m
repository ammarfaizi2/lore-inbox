Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTAOA6u>; Tue, 14 Jan 2003 19:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAOA6u>; Tue, 14 Jan 2003 19:58:50 -0500
Received: from are.twiddle.net ([64.81.246.98]:43400 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265567AbTAOA6u>;
	Tue, 14 Jan 2003 19:58:50 -0500
Date: Tue, 14 Jan 2003 17:07:41 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling
Message-ID: <20030114170741.A5751@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030113110036.A873@twiddle.net> <20030114035737.07C672C2BD@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114035737.07C672C2BD@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Jan 14, 2003 at 02:57:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:57:11PM +1100, Rusty Russell wrote:
> I don't understand this.  For a weak symbol, st_shndx won't be
> SHN_UNDEF.

For an *undefined* weak symbol it certainly will.


r~
