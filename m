Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSAVSzm>; Tue, 22 Jan 2002 13:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289350AbSAVSxD>; Tue, 22 Jan 2002 13:53:03 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:20455 "HELO smeg")
	by vger.kernel.org with SMTP id <S289346AbSAVSu7>;
	Tue, 22 Jan 2002 13:50:59 -0500
From: "Lee Packham" <linux@mswinxp.net>
To: "'Daniel Nofftz'" <nofftz@castor.uni-trier.de>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] amd athlon cooling on kt266/266a chipset
Date: Tue, 22 Jan 2002 18:51:12 -0000
Message-ID: <000901c1a375$c3493320$8119fea9@lee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe.... just maybe... attach the patch?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Daniel Nofftz
Sent: 22 January 2002 17:15
To: Linux Kernel Mailing List
Subject: [patch] amd athlon cooling on kt266/266a chipset

hi there!

a few month ago someone has posted a patch for enabling the disconneect
on STPGND detect function in the kt133/kt133a chipset. for those who
don't
know what this does: it sets a bit in a register of the northbridge of
the
chipset to enable the power saving modes of the athlon/duron/athlon xp
prozessors.
i did not found any patch which enables this function on an kt266/kt266a
board. so i modified this patch (
http://groups.google.com/groups?q=via_disconnect&hl=en&selm=linux.kernel
.20010903002855.A645%40gondor.com&rnum=1
)
to support the kt266 and kt266a chipset to.

now i am looking for people to test the patch and repord, whether it
works
allright on other computers than my computer (i tested this patch on an
epox 8kha+ whith an xp1600+).

if you want to test this patch:
1. first apply the patch
2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
   in the kernel config
3. add to the "append" line in /etc/lilo.conf the "amd_disconnect=yes"
statemand (or after reboot enter at the kernel-boot-prompt
"amd_disconnect=yes")
4. build a knew kernel
5. report to me, whether you have problems ...

if the patch gets a good feedback, maybe it is something for the
official
kernel tree ?

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

