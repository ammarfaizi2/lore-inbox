Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSEGJen>; Tue, 7 May 2002 05:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEGJem>; Tue, 7 May 2002 05:34:42 -0400
Received: from ns.tasking.nl ([195.193.207.2]:17161 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315424AbSEGJel>;
	Tue, 7 May 2002 05:34:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15575.40787.197975.746184@koli.tasking.nl>
Date: Tue, 7 May 2002 11:33:07 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
From: Kees Bakker <rnews@altium.nl>
Subject: Re: 3c59x: LK1.1.17 gives No MII transceivers found
In-Reply-To: <3CD79AFA.F3B11E95@zip.com.au>
X-Mailer: VM 7.00 under Emacs 20.6.1
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> It's just random debug code.
>> 
>> Is that also true for the "***WARNING*** No MII transceivers found!"
>> message?

Andrew> Not really.  The driver shouldn't have gone looking for MII
Andrew> transceivers for a 3c900.

Andrew> I'll take a look, see if I can remember how the darn driver
Andrew> works.  3c59x is very much in "it works, don't futz with it" mode...

Andrew> Does the 3c900 actually work correctly?
>> 
>> I can't tell, because since it hangs at boot. That is, every kernel after
>> 2.5.7 that I could build, including 2.5.13. (I'm having those hda: lost
>> interrupt messages).

Andrew> Ouch.  So 2.5.7 worked OK?  What sort of controller and disks do
Andrew> you have?

The 2.5.7 worked reasonably well (for a few days, I think). Except that it
hung at one point and I decided to go back to 2.4.17. My plan was to try it
again with a newer kernel.

My system:
- MSI MSI K7T266 Pro, with an Athlon 1.3 GHz
- IBM Deskstar 60GXP, 40Gb using onboard IDE controller
- 3c900
- 3c905C
- Adaptec 2940
- Hauppauge Win/TV Theatre
- USB: Iiyama monitor, Dlink webcam

Shall I try to build with LK1.1.16?
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
Evil has been dealt a serious blow, but will be back
