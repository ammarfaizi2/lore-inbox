Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRAPKlI>; Tue, 16 Jan 2001 05:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAPKk6>; Tue, 16 Jan 2001 05:40:58 -0500
Received: from felix.convergence.de ([212.84.236.131]:5386 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S130337AbRAPKkt>;
	Tue, 16 Jan 2001 05:40:49 -0500
Date: Tue, 16 Jan 2001 11:40:18 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116114018.A28720@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101152035090.5713-100000@elte.hu> <200101152033.f0FKXpv250839@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101152033.f0FKXpv250839@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jan 15, 2001 at 03:33:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Albert D. Cahalan (acahalan@cs.uml.edu):
> Rather than combining open() with sendfile(), it could be combined
> with stat(). Since the syscall would be new anyway, it could skip
> the normal requirement about returning the next free file descriptor
> in favor of returning whatever can be most quickly found.

I don't know how Linux does it, but returning the first free file
descriptor can be implemented as O(1) operation.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
