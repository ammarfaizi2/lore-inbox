Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292907AbSBVPft>; Fri, 22 Feb 2002 10:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292906AbSBVPfb>; Fri, 22 Feb 2002 10:35:31 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:51098 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S292905AbSBVPfY>;
	Fri, 22 Feb 2002 10:35:24 -0500
Message-ID: <3C766511.5050808@nokia.com>
Date: Fri, 22 Feb 2002 17:34:41 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_93
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2002 15:35:22.0271 (UTC) FILETIME=[8A5A72F0:01C1BBB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Find new affix release Affix-0_93 on
http://affix.sourceforge.net

Version 0.93 [22.02.2002]
- [fix] extern inline replaced by static inline
	prevent un-optimized compilation problem
- [new] usb driver support any bluetooth deivices
- [fix] btsdp_browse connection establishment
- [new] L2CAP socket can be connected through any Bluetooth adapter
	sockaddr_l2cap {
	... old fields..
	BD_ADDR		local;
	}
	set *local* to Bluetooth address of the adapter to connect through.
	or BDADDR_ANY
- [fix] hci devices are removing well on *btctl close_uart *
- [fix] added locks for l2cap objects
- [fix] compilation problem for older kernel (2.4.7 at least) - headers ...



Br, Dmitry

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



