Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262001AbTDACn7>; Mon, 31 Mar 2003 21:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbTDACn7>; Mon, 31 Mar 2003 21:43:59 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:2462 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S262001AbTDACn5>; Mon, 31 Mar 2003 21:43:57 -0500
Message-ID: <3E88FE8E.9070707@seme.com.au>
Date: Tue, 01 Apr 2003 10:50:54 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
References: <3E88FA24.7040406@seme.com.au>
In-Reply-To: <3E88FA24.7040406@seme.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> I have a problem with the via-rhine on this board timing out.

Quick followup.
Loading module with debug=3 makes it happen a lot less, but
it still happens and frequently.

Relevant dmesg snip

eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Reset succeeded.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 40.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 60.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Reset succeeded.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 40.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 60.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Reset succeeded.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 40.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 60.



-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

