Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313277AbSDESQW>; Fri, 5 Apr 2002 13:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313355AbSDESQM>; Fri, 5 Apr 2002 13:16:12 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:42688 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S313277AbSDESQC>; Fri, 5 Apr 2002 13:16:02 -0500
From: <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David N. Welton" <davidw@dedasys.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: forth interpreter as kernel module
Date: Fri, 5 Apr 2002 20:16:27 +0200
Message-Id: <20020405181627.22453@mailhost.mipsys.com>
In-Reply-To: <E16tHSB-00078F-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would be interested in comments on what should be fixed in the code,
>> although I may not have time to act on them.
>
>Strange. The one area forth does have sort of relevance may be outside the
>x86 world. The portable boot rom standards (the one everyone ignored for
>x86) is all about forth stuff. I don't know if anyone has use for a forth
>engine that can speak that ?

Yes, an OpenFirmware emulator would be interesting. It would allow to
softboot OF PCI cards on non-OF machines, and would allow to implement
properly resume from sleep on some desktop G4s that will power off the
PCI bus during sleep (some cards need to be re-softbooted, like video 
ones, and in some case, you really want the vendor firmware to run).

Ben.



