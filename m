Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQL2MxQ>; Fri, 29 Dec 2000 07:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131013AbQL2MxG>; Fri, 29 Dec 2000 07:53:06 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:49426 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130989AbQL2Mws>; Fri, 29 Dec 2000 07:52:48 -0500
Date: Fri, 29 Dec 2000 13:20:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Ryan Sizemore <ryan831@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ATX halt
Message-ID: <20001229132049.K22081@arthur.ubicom.tudelft.nl>
In-Reply-To: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBIFHONDNEGJDKODONAEIDCDAA.ryan831@usa.net>; from ryan831@usa.net on Thu, Dec 28, 2000 at 11:59:06PM -1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 11:59:06PM -1000, Ryan Sizemore wrote:
>    I am new this whole 'posting to the mailing list' thing, so please
> excuse any obvious mistakes.

Ah, welcome. No mistakes so far :-)

>    I have a comp. running mandrake 7.2, and when i go to power it down, it
> gives me a screen full of errors, including a stackdump. It happens as the
> very last thing (including being after the file system is unmounted, so I
> highly doubt that the error is recorded somewhere. But i will hand-copy the
> stack for whomever thinks it may be useful. The error is reproduced every
> time, without equivication. Any insight or questions are much apriciated.
> The motherboard is a Soyo 5EMA+ r1.0 w/ ETEQ EQ82C6638 Chipset, and it has
> an Award BIOS.

Sounds like a broken BIOS (that never happens, right? ;-). Recompile
the kernel and enable "Use real mode APM BIOS call to power off".


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
