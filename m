Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRAPOky>; Tue, 16 Jan 2001 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbRAPOko>; Tue, 16 Jan 2001 09:40:44 -0500
Received: from felix.convergence.de ([212.84.236.131]:64778 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S130225AbRAPOkl>;
	Tue, 16 Jan 2001 09:40:41 -0500
Date: Tue, 16 Jan 2001 15:40:13 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was: sendpath()]]
Message-ID: <20010116154013.C32180@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010116061342.C12650@cadcamlab.org> <Pine.LNX.4.30.0101161329230.947-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101161329230.947-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 01:33:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Ingo Molnar (mingo@elte.hu):
> if you read my (radical) proposal, the identification is based on a kernel
> pointer and a 256-bit random integer. So non-negative integers are not
> needed. (file-IO system-calls would be modified to detect if 'Unix file
> descriptors' or pointers to 'native file descriptors' are passed to them,
> so this is truly radical.)

Yuck, don't pass pointers in kernel space to user space!
NT does it and look what kernel call argument verification havoc it
wrought over them!

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
