Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQL2SEz>; Fri, 29 Dec 2000 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130996AbQL2SEp>; Fri, 29 Dec 2000 13:04:45 -0500
Received: from [4.22.152.149] ([4.22.152.149]:20012 "HELO
	spanky.comspacecorp.com") by vger.kernel.org with SMTP
	id <S130061AbQL2SEf>; Fri, 29 Dec 2000 13:04:35 -0500
Date: Fri, 29 Dec 2000 11:29:00 -0600
Message-Id: <200012291729.eBTHT0w01182@spanky.comspacecorp.com>
From: Bill Priest <bpriest@comspacecorp.com>
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: 2.2.1x unknown kernel messages in syslog
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
		Running 2.2.19pre2 (but it happens w/ many previous 2.2.1(7-8) versions)
built w/ egcs-2.91.66, while connected w/ ppp over analog modem to windows
nt ras server; I get the following messages using ppp 2.4.0b4 (w/ MSCHAP-80)

Dec 29 09:22:59 kodi pppd[905]: pppd 2.4.0b4 started by bpriest, uid 500
Dec 29 09:23:01 kodi chat[910]: abort on (BUSY)
Dec 29 09:23:01 kodi chat[910]: abort on (NO ANSWER)
Dec 29 09:23:01 kodi chat[910]: send (AT^M)
Dec 29 09:23:01 kodi chat[910]: expect (OK)
Dec 29 09:23:01 kodi chat[910]: AT^M^M
Dec 29 09:23:01 kodi chat[910]: OK
Dec 29 09:23:01 kodi chat[910]:  -- got it 
Dec 29 09:23:01 kodi chat[910]: send (ATDTxxxxxxxxxx^M)
Dec 29 09:23:01 kodi chat[910]: expect (CONNECT)
Dec 29 09:23:01 kodi chat[910]: ^M
Dec 29 09:23:34 kodi chat[910]: ATDTxxxxxxxxxx^M^M
Dec 29 09:23:34 kodi chat[910]: CONNECT
Dec 29 09:23:34 kodi chat[910]:  -- got it 
Dec 29 09:23:34 kodi pppd[905]: Serial connection established.
Dec 29 09:23:34 kodi pppd[905]: Using interface ppp0
Dec 29 09:23:34 kodi pppd[905]: Connect: ppp0 <--> /dev/ttyS3
Dec 29 09:23:34 kodi kernel: ppp_ioctl: set dbg flags to 1f0000 
Dec 29 09:23:34 kodi kernel: ppp_ioctl: set flags to 1f0000 
Dec 29 09:23:34 kodi kernel: ppp_tty_ioctl: set xasyncmap 
Dec 29 09:23:34 kodi kernel: ppp_tty_ioctl: set xmit asyncmap ffffffff 
Dec 29 09:23:34 kodi kernel: ppp_ioctl: set flags to 1f0000 
Dec 29 09:23:34 kodi kernel: ppp_ioctl: set mru to 5dc 
Dec 29 09:23:34 kodi kernel: ppp_tty_ioctl: set rcv asyncmap ffffffff 
Dec 29 09:23:36 kodi kernel: ppp_tty_ioctl: set xmit asyncmap 0 
Dec 29 09:23:36 kodi kernel: ppp_ioctl: set flags to f1f0002 
Dec 29 09:23:36 kodi kernel: ppp_ioctl: set mru to 5dc 
Dec 29 09:23:36 kodi kernel: ppp_tty_ioctl: set rcv asyncmap ffffffff 
Dec 29 09:23:39 kodi kernel: ppp_ioctl: set flags to f1f0042 
Dec 29 09:23:41 kodi pppd[905]: local  IP address 192.168.220.50
Dec 29 09:23:41 kodi pppd[905]: remote IP address 192.168.220.46
Dec 29 09:23:41 kodi kernel: ppp_ioctl: set maxcid to 16 
Dec 29 09:23:41 kodi kernel: ppp_ioctl: set flags to f1f0046 
Dec 29 09:23:44 kodi kernel: ppp_ioctl: set flags to f1f0006 
Dec 29 09:23:53 kodi PAM_pwdb[956]: (su) session opened for user root by bpriest(uid=500)
Dec 29 09:24:38 kodi kernel: d (AT^M 
Dec 29 09:24:38 kodi kernel: hat[464 
Dec 29 09:24:40 kodi kernel:  24 11 
Dec 29 09:24:41 kodi kernel: i kerne 
Dec 29 09:24:42 kodi kernel: ).Dec 2 
Dec 29 09:24:43 kodi kernel: .<.z 
Dec 29 09:24:44 kodi kernel:  15 36 
Dec 29 09:24:45 kodi kernel: i k 
Dec 29 09:24:46 kodi kernel: Dec  
Dec 29 09:24:47 kodi kernel:  kodi k 
Dec 29 09:24:48 kodi kernel: NO ANSW 
Dec 29 09:24:55 kodi kernel: 0 70  kodi pp 
Dec 29 09:24:56 kodi kernel:  0A 44 hangup.D 
Dec 29 09:24:57 kodi kernel: ablis 
Dec 29 09:24:59 kodi kernel: ec 26  
Dec 29 09:29:15 kodi kernel: odi ker 

I'm not sure if they are causing a problem or not; (I seem to notice them
more when I'm surfing w/ netscape), however, the above were received while only
ftp'ing /var/log/messages to the remote machine.

Note telephone numbers x'ed out for privacy.

I'm not subscribe'ed to linux-kernel; so please copy me w/ any questions or
replies.

Note previously my asyncmap was set to 0 and the same thing occurred.
Note that I transferred the file while I was driving to work and the windows
ras machine timed out and disconnected (I presume).

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
