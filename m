Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316962AbSFFNU7>; Thu, 6 Jun 2002 09:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSFFNU6>; Thu, 6 Jun 2002 09:20:58 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:16355 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S316954AbSFFNUz>;
	Thu, 6 Jun 2002 09:20:55 -0400
Message-ID: <3CFF615E.50500@nokia.com>
Date: Thu, 06 Jun 2002 16:19:26 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>
CC: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release] Affix-1_00pre3  --- The most powerfull Bluetooth Protocol
 Stack.
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com> <3CEEC240.8030905@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2002 13:20:44.0893 (UTC) FILETIME=[F6D260D0:01C20D5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Find new Affix release Affix-1_00pre3 on http://affix.sourceforge.net
It has improved UART, USB and extra drivers.

Anycom, 3COM, Xircom works now.
Socket CF works

Version 1.0pre3 [06.06.2002]
- [fix] l2cap state machine
- [new] *btctl* now remembers found devices - device cache.
	*btctl list*	- to see the list
	*btctl flush*	- to forget it
	*btctl connect <id> ...
	actually id can be provided instead bda in every command.
- [new] any driver from BlueZ can be compiled in Affix.
	Just include <affix/bluez.h> instead <net/bluetooth/*.h>
- [fix] work on kernels < 2.4.7
- [fix] Socket CF card works now perfectly.
	(Socket changed device id to new one - it caused the problem)
- [new] Affix install pcmcia config file *.conf to /etc/pcmcia
	so that they are read automaticaly -  no needs to change
	/etc/pcmcia/config
- [new] new features for *btctl open_uart*:
	*btctl open_uart <device> <speed>
- [fix] Xircom card works now.
- [new] obex-server can work with different root-folders (AFE support)
- [new] btsdp starts automatically (SDPInit(SDP_SVC_PROVIDER)).
	so btsdp starts when btsrv does.
- [new] *btctl* andestand mnemonics for dev classes and shows it.


  Affix works on platforms (tested):
- i386.
- ARM (e.g. Compaq iPac).
- PowerPC (e.g. iMac).

Affix currently supports the following Bluetooth Profiles:
- General Access Profie
- Service Discovery Profile
- Serial Port Profile
- DialUp Networking Profile
- LAN Access Profile
- OBEX Object Push Profile
- OBEX File Transfer Profile
- PAN Profile



GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.

br, Dmitry
Nokia Research
+358 50 4836365


