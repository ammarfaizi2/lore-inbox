Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRLDRTI>; Tue, 4 Dec 2001 12:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRLDRRt>; Tue, 4 Dec 2001 12:17:49 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:17417 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S281643AbRLDRRL>; Tue, 4 Dec 2001 12:17:11 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: John Stoffel <stoffel@casc.com>
cc: Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Message-ID: <86256B18.005EE7DC.00@smtpnotes.altec.com>
Date: Tue, 4 Dec 2001 11:11:50 -0600
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It's not the CML1 language spec that interests me, just the user interface.  All
I care about is being able to do make menuconfig and make oldconfig, and get the
same results as before.  What goes on "under the surface" doesn't interest me at
all.

In fact, here's all I want to know about the whole CML2/kbuild 2.5 issue.  Right
now I upgrade my kernel like this (simplified slightly):

<apply latest patches>
mv .config ..
make mrproper
mv ../.config .
make oldconfig
make dep
make bzlilo modules modules_install
<reboot>

Will I still be able to do it this simply in 2.5.x?  (Assuming there's
eventually a 2.5.x I can get to compile cleanly.  :-)

Wayne




John Stoffel <stoffel@casc.com> on 12/04/2001 10:31:10 AM

To:   Christoph Hellwig <hch@caldera.de>
cc:   Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
      linux-kernel@vger.kernel.org, torvalds@transmeta.com (bcc: Wayne
      Brown/Corporate/Altec)

Subject:  Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5




Christoph> I still strongly object to it and I know lots of kernel
Christoph> hackers are the same opinion.

I'm not a hacker, but I think it's a good thing to move to CML2.  I've
tested it and it's got some nice features.  The Python issue I don't
think is too onerous to require of people.  And wasn't there someone
out there porting CML2 to straight C code?

Why are people so wedded to the CML1 language spec anyway?

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
      stoffel@lucent.com - http://www.lucent.com - 978-952-7548
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




