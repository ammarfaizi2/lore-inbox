Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291797AbSBAPNw>; Fri, 1 Feb 2002 10:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291796AbSBAPNo>; Fri, 1 Feb 2002 10:13:44 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:35731 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S291791AbSBAPNb>;
	Fri, 1 Feb 2002 10:13:31 -0500
Message-ID: <3C5AB093.5050405@nokia.com>
Date: Fri, 01 Feb 2002 17:13:23 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: affix-devel@lists.sourceforge.net
CC: Affix support <affix-support@lists.sourceforge.net>,
        Bluetooth-Drivers-for-Linux 
	<Bluetooth-Drivers-for-Linux@research.nokia.com>,
        NRC-WALLET DL <DL.NRC-WALLET@nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_9
In-Reply-To: <3C500D09.4080206@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Find new affix release Affix-0_9pre10 on
http://affix.sourceforge.net

Version 0.9 [01.02.2002]

!!! NOTES
    Do not patch the kernel with this version.
    Patch will be available soon

- btctl shows all available devices in the system
  btctl -i bt0
  "-i" this options is used to handle certain devices
- btuarto changed by btuart.o & btuart_cs.o
  btctl open_uart /dev/ttyS0
  btctl close_uart /dev/ttyS0
  commands are use to open Bluetooth adapters having UART interface
- Added HCI socket (internally used only now)
  BTPROTO_HCI
- Added some object locks
- Added btsdp_browse
  Use
  btsdp_browse <bda | local>
  to browse SDP server data base


br, Dmitry

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



