Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277074AbRJVQ5S>; Mon, 22 Oct 2001 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277072AbRJVQ5I>; Mon, 22 Oct 2001 12:57:08 -0400
Received: from cx838204-a.alsv1.occa.home.com ([24.16.83.66]:32929 "HELO
	shakti.rupa.com") by vger.kernel.org with SMTP id <S277064AbRJVQ4v>;
	Mon, 22 Oct 2001 12:56:51 -0400
To: Kelledin Tane <feralgod@home.com>
Cc: Volker Dierks <vd@mwi-online.de>, linux-kernel@vger.kernel.org
Subject: Re: VIA 686b Bug - once again :(
In-Reply-To: <200110211326.PAA01192@mail.mwi-online.de>
	<3BD2DCFB.C00E93B6@home.com>
From: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
Mail-Copies-To: never
Date: Mon, 22 Oct 2001 09:57:24 -0700
In-Reply-To: <3BD2DCFB.C00E93B6@home.com> (Kelledin Tane's message of "Sun,
 21 Oct 2001 09:34:35 -0500")
Message-ID: <m3wv1n7guj.fsf@shakti.rupa.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kelledin Tane <feralgod@home.com> writes:

>> So my questions is:
>> I'm going to buy a 3ware 6410(B)
>> IDE raid controller .. can I suspect
>> a failure safe system (in aspect to
>> the 686b problems) when all discs
>> are connected to the 3ware
>> controller?
> 
> I would certainly expect so.  I have a Gigabyte GA-7DX with the infamous VIA
> 686B southbridge...and an SBLive! Value...and I have no IDE devices at all
> (complete SCSI).  I have never encountered data corruption.


I experienced constant and reproducable data corruption on two via
motherboards.  One using 686 and one 686b.  However, not with the IDe
drives.  This was with a DDS4 scsi tape drive attached to either a
Adaptec or Advansys scsi controller.  A 2.5G file dump to tape would
never restore the same.  One the Adaptec card, I would get 1 or 2
blocks of 64bytes that would differ.  On the Advansys it would be 1 or
2 blocks of 63 bytes.

Switch to a PIII-500 on a BX motherboard and have had no problems.
The VIA motherboards are now in windows machines where the flakiness
of the OS is even worse than the hardware.

-- 
-rupa
