Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263397AbUKWMK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbUKWMK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbUKWMK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:10:58 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:64272 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S263498AbUKWMIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:08:09 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
References: <200411212045.51606.gene.heskett@verizon.net>
	<41A1F881.1000900@draigBrady.com>
	<200411221058.22276.gene.heskett@verizon.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: featuring the world's first municipal garbage collector!
Date: Tue, 23 Nov 2004 12:08:00 +0000
In-Reply-To: <200411221058.22276.gene.heskett@verizon.net> (Gene Heskett's
 message of "23 Nov 2004 04:46:46 -0000")
Message-ID: <87653wydi7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2004, Gene Heskett yowled:
> On Monday 22 November 2004 09:32, P@draigBrady.com wrote:
>>Gene Heskett wrote:
>>> Greetings;
>>>
>>> Silly Q of the day probably, but what do I set in a Makefile for
>>> the -march=option for building on a 233 mhz Pentium 2?
>>
>>http://www.pixelbeat.org/scripts/gcccpuopt
> 
> Thanks very much.  Obviously someone else needed to scratch this itch 
> too.  This should produce the correct results when running on the 
> target machine.  Here, it produces this:
> [root@coyote CIO-DIO96]# sh ../gcccpuopt
>  -march=athlon-xp -mfpmath=sse -msse -mmmx -m3dnow

... which is peculiar, as -mmmx -msse is redundant, as is -mmmx -m3dnow,
and all three of those flags are the end are implied by -march=athlon-xp
anyway.

(-mfpmath=sse *is* useful on non-64-bit platforms, though.)

-- 
`The sword we forged has turned upon us
 Only now, at the end of all things do we see
 The lamp-bearer dies; only the lamp burns on.'
