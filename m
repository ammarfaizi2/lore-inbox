Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSC2F2K>; Fri, 29 Mar 2002 00:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313360AbSC2F17>; Fri, 29 Mar 2002 00:27:59 -0500
Received: from are.twiddle.net ([64.81.246.98]:5779 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S313358AbSC2F1p>;
	Fri, 29 Mar 2002 00:27:45 -0500
Date: Thu, 28 Mar 2002 21:27:37 -0800
From: Richard Henderson <rth@twiddle.net>
To: =?iso-8859-1?Q?M=E5nsRullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix alpha NR_SYSCALLS
Message-ID: <20020328212737.B30037@twiddle.net>
Mail-Followup-To: =?iso-8859-1?Q?M=E5nsRullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203211735.g2LHZFb02603@xq806.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 06:35:15PM +0100,  MånsRullgård  wrote:
> -#define NR_SYSCALLS 378
> +#define NR_SYSCALLS 381

Actually, the correct value is 382.  I've fixed this
and added a compile-time check for correctness.


r~
