Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315392AbSEGI63>; Tue, 7 May 2002 04:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315393AbSEGI62>; Tue, 7 May 2002 04:58:28 -0400
Received: from ns.tasking.nl ([195.193.207.2]:15625 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315392AbSEGI61>;
	Tue, 7 May 2002 04:58:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15575.38538.231057.425097@koli.tasking.nl>
Date: Tue, 7 May 2002 10:55:38 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
From: Kees Bakker <rnews@altium.nl>
Subject: Re: 3c59x: LK1.1.17 gives No MII transceivers found
In-Reply-To: <3CD78BDC.B6ED1BA5@zip.com.au>
X-Mailer: VM 7.00 under Emacs 20.6.1
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> Kees Bakker wrote:
>> 
>> In 2.5.8 there was an update of the 3c59x driver. I have two NICs,
>> both use this driver, a 3c900 Boomerang and a 3c905C Tornado.
>> 
>> Linux 2.4.17 and 2.5.7 both report
>> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.16
>> 00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.16
>> 
>> However, the new driver produces:
>> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.17
>> phy=0, phyx=24, mii_status=0xffff
>> phy=1, phyx=0, mii_status=0xffff

Andrew> It's just random debug code.

Is that also true for the "***WARNING*** No MII transceivers found!"
message?

Andrew> Does the 3c900 actually work correctly?

I can't tell, because since it hangs at boot. That is, every kernel after
2.5.7 that I could build, including 2.5.13. (I'm having those hda: lost
interrupt messages).
-- 
**************************************
Kees Bakker
Senior Software Designer
Altium - Think it, Design it, Build it
Phone  : +31 33 455 8584
Fax    : +31 33 455 5503
E-Mail : Kees.Bakker@altium.nl
URL    : http://www.altium.com
**************************************
English is wonderful, used correctly
