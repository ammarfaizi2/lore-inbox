Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQKNSFp>; Tue, 14 Nov 2000 13:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbQKNSFg>; Tue, 14 Nov 2000 13:05:36 -0500
Received: from grad.physics.sunysb.edu ([129.49.56.86]:56333 "EHLO
	grad.physics.sunysb.edu") by vger.kernel.org with ESMTP
	id <S130108AbQKNSFV>; Tue, 14 Nov 2000 13:05:21 -0500
Date: Tue, 14 Nov 2000 12:35:11 -0500 (EST)
From: Rui Sousa <rsousa@grad.physics.sunysb.edu>
To: "Willis L. Sarka" <wlsarka@the-republic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <Pine.LNX.4.30.0011131751160.21258-100000@matrix.the-republic.org>
Message-ID: <Pine.LNX.4.21.0011141222120.18636-100000@grad.physics.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Willis L. Sarka wrote:

> I get a hard lockup when trying to play a mp3 with XMMS;
> Sound Blaster Live card.  The first second loops, and I lose all
> connectivity to the machine; I can't ping it, can't to a an Alt-Sysq,
> nothing.

Is this when you try to play something for the first time or
it just happens sometimes?

> Details:
> 
> running RedHat 7.0
> using kernel 2.4.0-test11pre4
> emu10k1 compiled as a module
> system is a Dell Dimension 4100 (815e based, 512mb ram, 3com 3c905c cardA)
> 
> I'll try to compile in soundcore and emu10k1 into the kernel, foregoing
> any modules and see if that helps.  I will also revert back to
> 2.4.0-test10 as well just to test.

Yes, it would be good to know when the problems started.

>  If anyone needs further information,
> let me know.

What is the output of:

/sbin/lspci -v

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
