Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132942AbRBRO1X>; Sun, 18 Feb 2001 09:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRBRO1N>; Sun, 18 Feb 2001 09:27:13 -0500
Received: from ns.suse.de ([213.95.15.193]:18442 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132942AbRBRO1E>;
	Sun, 18 Feb 2001 09:27:04 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] a more efficient BUG() macro
In-Reply-To: <18856.982454476@ocs3.ocs-net>
From: Andi Kleen <ak@suse.de>
Date: 18 Feb 2001 15:27:01 +0100
In-Reply-To: Keith Owens's message of "18 Feb 2001 01:03:35 +0100"
Message-ID: <oupae7k83t6.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:
> 
> Would people prefer the C/ASM filename in BUG() messages instead of the
> include header?  If so I will add it to my todo list for the makefile
> rewrite.  Of course you can still use __FILE__ and __LINE_ if you
> really want to report the error against the include file.

I think include file name makes more sense, otherwise you'll have a hard time
to find the actual BUG check. If someone wants more they can decode the oops.


-Andi
