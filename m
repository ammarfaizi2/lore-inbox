Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267990AbRGVPOI>; Sun, 22 Jul 2001 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbRGVPN7>; Sun, 22 Jul 2001 11:13:59 -0400
Received: from ns.suse.de ([213.95.15.193]:61196 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267990AbRGVPNu>;
	Sun, 22 Jul 2001 11:13:50 -0400
To: "Mike Black" <mblack@csihq.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0"
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1>
	<3B59AFF7.8061645B@mandrakesoft.com> <01072201370202.02679@starship>
	<20010721165346.U3889@opus.bloom.county>
	<009601c11298$70a3da80$b6562341@cfl.rr.com>
X-Yow: I'm a fuschia bowling ball somewhere in Brittany
From: Andreas Schwab <schwab@suse.de>
Date: 22 Jul 2001 17:13:54 +0200
In-Reply-To: <009601c11298$70a3da80$b6562341@cfl.rr.com> ("Mike Black"'s message of "Sun, 22 Jul 2001 06:24:06 -0400")
Message-ID: <je3d7pxah9.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.105
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Mike Black" <mblack@csihq.com> writes:

|> Actually -- is it possible (or desirable) to make ALL kernel daemons begin
|> with say "_" or some other special character to distinguish them from
|> userland threads?  The "k......d" paradigm is OK but not very distinctive.
|> That way you have a simple line in the kernel docs that says "Any process
|> with a leading _ is a kernel process and should NEVER be killed or otherwise
|> messed with except as noted elsewhere in the docs".
|> 
|> Also would make it easy for things like ps, top and other process-aware
|> things to have a really simple "show kernel processes only" option.

Kernel threads can easily be identified by having a zero virtual size.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
