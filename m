Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280538AbRKNMf6>; Wed, 14 Nov 2001 07:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKNMfs>; Wed, 14 Nov 2001 07:35:48 -0500
Received: from ns.suse.de ([213.95.15.193]:38158 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280538AbRKNMfl> convert rfc822-to-8bit;
	Wed, 14 Nov 2001 07:35:41 -0500
To: dharter@lycos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this a kernel problem? segmentation fault
In-Reply-To: <IPKBFBEEDJJJACAA@mailcity.com>
X-Yow: TAPPING?  You POLITICIANS!  Don't you realize that the END of the
 ``Wash Cycle'' is a TREASURED MOMENT for most people?!
From: Andreas Schwab <schwab@suse.de>
Date: 14 Nov 2001 13:35:39 +0100
In-Reply-To: <IPKBFBEEDJJJACAA@mailcity.com> ("Donald Harter"'s message of "Tue, 13 Nov 2001 19:40:08 -0600")
Message-ID: <je8zd9o7hg.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Donald Harter" <dharter@lycos.com> writes:

|>      I started by debugging this program where I was getting a
|>      segmentation fault.  I used gdb and traced the bug to a call
|>      instruction.  I dissasembled the code and stepped through the
|>      instructions.  The program got a segmentation fault when it
|>      executed an assembly language call instruction. Using gdb I was
|>      able to disassemble the instructions at the called address. Why
|>      can gdb disasemble instructions at a call address and a call to
|>      that address fails with a segmentation fault?

Perhaps a stack overflow, or stack pointer is pointing to lala land.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
