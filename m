Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUCUSPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbUCUSPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:15:45 -0500
Received: from bay4-f10.bay4.hotmail.com ([65.54.171.10]:2056 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263686AbUCUSPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:15:34 -0500
X-Originating-IP: [213.42.2.21]
X-Originating-Email: [waelghandour@msn.com]
From: "Wael Ghandour" <waelghandour@msn.com>
To: jad@saklawi.info, linux-kernel@vger.kernel.org
Cc: hisham@hisham.cc, llug-users@greencedars.org
Subject: RE: [llug-users] Fwd: MAC / IP conflict
Date: Sun, 21 Mar 2004 19:15:32 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY4-F10XmYYknzVPOs0003a730@hotmail.com>
X-OriginalArrivalTime: 21 Mar 2004 18:15:33.0289 (UTC) FILETIME=[8015E990:01C40F70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jad,

Giving more details about your network topology (switched vs. non-switched, 
segmentation, e.t.c) would be useful. As a primer, I suggest looking into 
arpwatch, setting major arp-entries (such as your gateway address) as 
static, as well as investigating the use of ettercap. If the switches your 
provider is using on his LAN are manageable, nabbing the culprit will be a 
piece of cake.

Good luck.

Wael

>From: Jad Saklawi <saki@mail.portland.co.uk>
>Reply-To: Jad Saklawi <jad@saklawi.info>
>To: linux-kernel@vger.kernel.org
>CC: hisham@hisham.cc,  llug-users@greencedars.org
>Subject: [llug-users] Fwd: MAC / IP conflict
>Date: Sun, 21 Mar 2004 07:09:47 +0200
>MIME-Version: 1.0
>Received: from byblos.greencedars.org ([66.93.193.9]) by 
>mc5-f15.hotmail.com with Microsoft SMTPSVC(5.0.2195.6824); Sun, 21 Mar 2004 
>09:13:10 -0800
>Received: (qmail 381 invoked by uid 505); 21 Mar 2004 17:22:08 -0000
>Received: (qmail 373 invoked from network); 21 Mar 2004 17:22:08 -0000
>X-Message-Info: JGTYoYF78jEHjJx36Oi8+YDSEg8qKPPD
>Mailing-List: contact llug-users-help@greencedars.org; run by ezmlm
>Precedence: bulk
>X-No-Archive: yes
>List-Post: <mailto:llug-users@greencedars.org>
>List-Help: <mailto:llug-users-help@greencedars.org>
>List-Unsubscribe: <mailto:llug-users-unsubscribe@greencedars.org>
>List-Subscribe: <mailto:llug-users-subscribe@greencedars.org>
>Delivered-To: mailing list llug-users@greencedars.org
>Message-ID: <405D239B.30602@mail.portland.co.uk>
>User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 
>Thunderbird/0.3
>X-Accept-Language: en-us, en
>X-SA-Exim-Mail-From: saki@mail.portland.co.uk
>X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on calcium.dnsix.com
>X-Spam-Level: X-Spam-Status: No, hits=0.4 required=10.0 
>tests=DATE_IN_PAST_12_24 autolearn=no version=2.63
>X-Spam-Report: *  0.4 DATE_IN_PAST_12_24 Date: is 12 to 24 hours before 
>Received: date
>X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
>X-SA-Exim-Scanned: Yes
>X-uvscan-result: clean (1B56Tx-0003PK-Ei)
>Return-Path: llug-users-return-443-waelghandour=msn.com@greencedars.org
>X-OriginalArrivalTime: 21 Mar 2004 17:13:11.0151 (UTC) 
>FILETIME=[C998F7F0:01C40F67]
>
>----- Forwarded message from Hisham Mardam Bey -----
>    Date: Sun, 21 Mar 2004 13:52:59 +0200
>
>In short, I need to detect when someone on the network uses my MAC and
>my IP address.
>
>Longer story follows. I am on a LAN which might have some potentially
>dangerous users. Those users might spoof my MAC address and additionally
>use my IP address, thus forcing my box to go offline, and not be able to
>communicate with my gateway. What I need is a passive way to check for
>something of the sort, and perhaps a notofication into syslog (the
>latter is not very important).
>
>
>
>--------------------------------------------------------------
>subscribe: llug-users-subscribe@greencedars.org
>unsubscribe: llug-users-unsubscribe@greencedars.org
>help: llug-users-help@greencedars.org
>--------------------------------------------------------------
>

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

