Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286746AbRLVJd0>; Sat, 22 Dec 2001 04:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286748AbRLVJdR>; Sat, 22 Dec 2001 04:33:17 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:59783 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S286746AbRLVJdH>;
	Sat, 22 Dec 2001 04:33:07 -0500
Message-ID: <3C2452FF.4070108@nokia.com>
Date: Sat, 22 Dec 2001 11:31:43 +0200
From: Dmitri Kassatkine <dmitri.kassatkine@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
To: Affix support <affix-support@lists.sourceforge.net>,
        affix-devel@lists.sourceforge.net,
        Bluetooth-Drivers-for-Linux 
	<Bluetooth-Drivers-for-Linux@research.nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New release: Affix-0_9pre7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Find new Affix release Affix-0_9pre7 on http://affix.sourceforge.net

- *pragma pack* changed to __attribute__ ((packed)) everywhere
  tested on Compaq iPAC
- Added dynamic buffer/credit management in RFCOMM
- Added support for multiple flags in /etc/bluetooth/services
  added *std* flag. When set connects socket/bty to stdin/stdout
- Added /etc/bluetooth/serial
- Fixed RFCOMM_SetType. If set to RFCOMM_BTY, transmission
  disabled on /dev/bty until it will be opened
- PF_BLUETOOTH changed to PF_AFFIX to prevent mixing with BlueZ
- Fixed CID allocation. Prevented active CID allocation.
- SDP: Added functions that convert UUID to a string
  as a protocol, service class, profile descriptor,
  and as an hexadecimal number.
- Some other minor coding and fixes in the SDP (client side).
- sdp/drivers: finished and fixed the browse program.
  Creation of two other programs (channels and service)
  and put a README.txt that explains what do they do.




Merry Christmas and Happy New Year 2002!

br, Dmitri

-- 
 Dmitri Kassatkine
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitri.kassatkine@nokia.com


