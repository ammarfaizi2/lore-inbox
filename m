Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLPBbH>; Sun, 15 Dec 2002 20:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLPBbH>; Sun, 15 Dec 2002 20:31:07 -0500
Received: from are.twiddle.net ([64.81.246.98]:32640 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262662AbSLPBbG>;
	Sun, 15 Dec 2002 20:31:06 -0500
Date: Sun, 15 Dec 2002 17:38:27 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 (minor) Alpha probs in 2.5.51
Message-ID: <20021215173827.A10954@twiddle.net>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
References: <20021216003327.GC709@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216003327.GC709@gallifrey>; from gilbertd@treblig.org on Mon, Dec 16, 2002 at 12:33:27AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:33:27AM +0000, Dr. David Alan Gilbert wrote:
> arch/alpha/kernel/built-in.o(.data+0x3030): undefined reference to
> `cia_bwx_inb'
> arch/alpha/kernel/built-in.o(.data+0x3038): undefined reference to
> `cia_bwx_inw'

Fixed in current TOT.

> 2) This is a kind of subtle one.  Straight after boot up if I run 'w'
> or 'top' I get the warning:
> 
> Unknown HZ value! (831) Assume 1024.
> 
> This value creeps up:
> 
> Unknown HZ value! (958) Assume 1024.
> 
> over a period of a few minutes till the warning goes away.

Dunno.  Could be your clock chip is going bad.


r~
