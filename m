Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280812AbRKLOht>; Mon, 12 Nov 2001 09:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280810AbRKLOhk>; Mon, 12 Nov 2001 09:37:40 -0500
Received: from cs6625192-102.austin.rr.com ([66.25.192.102]:9999 "EHLO
	mail1.cirrus.com") by vger.kernel.org with ESMTP id <S280809AbRKLOhX>;
	Mon, 12 Nov 2001 09:37:23 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C022FB87B@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Shawfeng Dong'" <dong@ucolick.org>,
        "Woller, Thomas" <twoller@crystal.cirrus.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: CS4281 on Dell Inspiron 2100 running Redhat 7.2 
Date: Mon, 12 Nov 2001 08:36:10 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have never been able to figure out why some machines need a POR
in order to work after running a windows based OS (win2k and
win98se I seem to remember both cause this behavior).  I have
tried adding resets into the init code that the part understands,
but no help.  My belief is that the BIOS is not properly
resetting the chip to the same consistent state on a warm boot as
a cold boot.  Since there are no longer any h/w persons at Cirrus
to work with probing the state of the cs4281 during this failure
(part has been end-of-lifed), and getting DELL to open up the
BIOS is most likely not going to happen, then I don't anticipate
a solution from me.  more trial and error work might yield an
answer... else you'll have to power the machine each time
rebooting :(  wish i had more.  if you want the cs4281
Programming manual, and do some register twiddling yourself, i
can send directly to you. i have been able to get this document
out without requiring an NDA.
thanks
Tom Woller
twoller@crystal.cirrus.com

-----Original Message-----
From: Shawfeng Dong [mailto:dong@ucolick.org]
Sent: Saturday, November 10, 2001 11:33 PM
To: twoller@crystal.cirrus.com
Cc: linux-kernel@vger.kernel.org
Subject: CS4281 on Dell Inspiron 2100 running Redhat 7.2 


Hi,

I installed both Windows 2000 and RedHat Linux 7.2 onto my Dell
Inspiron
2100 laptop. The sound card is  Cirrus Logic Crystal CS4281 PCI
Audio. It
works fine under W2k, also fine under Linux if the laptop boots
directly
into Linux. But there is a weird problem: if I reboot the
computer from W2k
into Linux, it is unable to load the sound driver.

Do you have any idea what may cause this weird behavior? Or can
you send me
the latest driver? If you need more detailed information, please
let me
know.

Thanks and best wishes,

Shaw

