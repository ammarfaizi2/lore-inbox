Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLGGb5>; Thu, 7 Dec 2000 01:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbQLGGbq>; Thu, 7 Dec 2000 01:31:46 -0500
Received: from pop.gmx.net ([194.221.183.20]:61309 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129909AbQLGGbj>;
	Thu, 7 Dec 2000 01:31:39 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Thu, 7 Dec 2000 06:59:01 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012010234320.20188-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012010234320.20188-100000@coffee.psychology.mcmaster.ca>
Subject: Re: 2.4.0-test12-pre3: kernel: APIC error on CPU0: 08(00) /Gigabyte GA-586DX SMP_BOARD
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00120706590100.03542@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Mark,

there is one thing, that is some kind of curious:

using 2.4.0-test12pre5 I've many apic errors with CPU1 a n d CPU0:

Dec  7 06:52:04 nmb kernel: APIC error on CPU1: 04(00)
Dec  7 06:52:04 nmb kernel: APIC error on CPU0: 02(00)
Dec  7 06:52:04 nmb kernel: APIC error on CPU0: 04(00)
Dec  7 06:52:07 nmb kernel: APIC error on CPU0: 02(00)
Dec  7 06:52:07 nmb kernel: APIC error on CPU1: 04(00)


running 2.4.0-test11ac4 apic errors only appear with CPU0:

Dec  6 13:41:33 nmb kernel: APIC error on CPU0: 01(00)
Dec  6 13:41:33 nmb kernel: APIC error on CPU0: 02(00)
Dec  6 13:42:07 nmb last message repeated 2 times
Dec  6 13:42:28 nmb last message repeated 10 times
Dec  6 13:42:32 nmb kernel: APIC error on CPU0: 04(00)
Dec  6 13:42:34 nmb kernel: APIC error on CPU0: 02(00)
Dec  6 13:42:39 nmb last message repeated 4 times
Dec  6 13:42:40 nmb kernel: APIC error on CPU0: 08(00)
Dec  6 13:42:49 nmb kernel: APIC error on CPU0: 02(00)
Dec  6 13:42:55 nmb kernel: APIC error on CPU0: 08(00)
Dec  6 13:43:02 nmb kernel: APIC error on CPU0: 02(00)

and n e v e r on CPU1 !
today I will compile 2.4.0-test12pre7 and 'll see....

kind regards
Norbert



On Friday 01 December 2000 08:36, Mark Hahn wrote:
> > > unfortunately, many SMP boards have noisy APIC lines.
> >
> > Hallo Mark,
> >
> > thank you for your immediate reply!
> > Do APIC errors mean => hardware errors? With the actual kernel
>
> they are corrected errors.  that is, the apic checksums its messages
> and retries.  obviously, if the corruption is bad enough, it'll hang.
>
> > (2.4.0-test12pre3) they apear less often...
>
> there have been tweaks to the kernel code that handles the error
> reports, and there have been changes in how the kernel uses apics.
>
> > Can I do anything to solve this problem besides buying a new board (I do
> > not need a new computer ;o))?
>
> nope.  among people who have abit bp6's (very prone to this problem),
> a number of voodoo techniques are used, including >=300W power,
> fan on the BX chipset, bios updates, etc.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
