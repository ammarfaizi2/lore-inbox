Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSIWTOD>; Mon, 23 Sep 2002 15:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSIWTNV>; Mon, 23 Sep 2002 15:13:21 -0400
Received: from fes4-mail.whowhere.com ([209.202.220.170]:40582 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S261343AbSIWTMs>;
	Mon, 23 Sep 2002 15:12:48 -0400
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2002 20:17:38 +0100
From: "svetljo" <svetljo@lycos.com>
Message-ID: <JOGPEBMEIODLJAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: svetljo@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: via-rhine, VT6103 and VT8235
X-Sender-Ip: 131.188.24.131
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi just found previous report about my troubles
dating 2002-07-20
http://marc.theaimsgroup.com/?l=linux-kernel&m=102718248323184&w=2

and the fix is already in 2.4.20-pre7 
but sadly i still have the problem with the fix applied

my local LAN is 10Mb and the onboard NIC doesn't want to do anything
else then 100Mb, and i get a lot of errors 
ETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Transmit timed out, status 0000, PHY status 786d, resetting...
[etc, etc, ...]

mobo EPoX 8K5A-3+ KT333 + VT8235 2.4.19-pre10jam3(with/without the fix) 
couldn't find 2.4.20-pre7 with SGI's xfs :( to test

dmesg @ http://varna.demon.co.uk/~svetlio/RhineETH

fix  @ http://varna.demon.co.uk/~svetlio/via-rhine.c.diff
lspci -vvv @ http://varna.demon.co.uk/~svetlio/LSPCI

so i wanted to ask whether someone has it working
and if there is a newer fix? :)

Best Regards,

svetljo

---
Svetoslav Dimitrov Slavtschev

svetljo@lycos.com
svetoslav@web.de



____________________________________________________________
Tired of all the SPAM in your inbox? Switch to LYCOS MAIL PLUS
http://www.mail.lycos.com/brandPage.shtml?pageId=plus
