Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbRGMVO3>; Fri, 13 Jul 2001 17:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGMVOZ>; Fri, 13 Jul 2001 17:14:25 -0400
Received: from shodan.in-trier.de ([198.22.51.3]:22539 "EHLO
	shodan.in-trier.de") by vger.kernel.org with ESMTP
	id <S266980AbRGMVOP>; Fri, 13 Jul 2001 17:14:15 -0400
Date: Fri, 13 Jul 2001 23:14:13 +0200
From: andreas <andi@in-trier.de>
X-Mailer: The Bat! (v1.47 Halloween Edition) UNREG / CD5BF9353B3B7091
Reply-To: Andreas Otto <andi@in-trier.de>
X-Priority: 3 (Normal)
Message-ID: <66216707168.20010713231413@in-trier.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x crash Siemens mainboard 512+ ram
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

trying to solve a problem here:

Siemens Mainboard S26361-D with Intel Chipset (having some extra
features for beeing used rackmounted / in cabinets), currently running
with Intel P-III 933MHz and 512 MB Ram.

As soon as i try to upgrade Ram to something more than 512 MB the
kernel crashs while booting, right after unpacking its image or a
little bit later after detecting ide-devices.

Now i tried to install 768 MB in 3 x 256 MB 133MHz ... (same results
with 3 x 512 or 2x256 + 1x128 - simply anything above 512)

Kernel 2.4.6-ac2:

- kernel unpacks and detects 770xxx KB Ram (768 MB)
- it shows 4 rows of hash table informations and hangs, the last line
  is about "Page-cache hash table", then deadlock.

Kernel 2.4.2:

- kernel boots up until it detects the ide-devices, showing ide0 with
  its information, ide1 with its information, then it stands still,
  deadlock, before it can show the partition informations

Another try with 2.4.2 does a kernel Oops 0002 at the same point.

Siemens does not to provide any information on the mainboard, i didn't
find any newer bios version i could try, nor did i find any more
information about crashing kernels with installed 512+ MB with these
kind of problems i've got here.

Someone has an idea, what i could try to do or try to debug, to get
more information on this? I'm willing to really work hard on it :)

Thank you very much for reading.

Andreas


