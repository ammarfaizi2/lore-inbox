Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUITGtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUITGtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 02:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUITGtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 02:49:39 -0400
Received: from web50907.mail.yahoo.com ([206.190.38.127]:22154 "HELO
	web50907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266115AbUITGth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 02:49:37 -0400
Message-ID: <20040920064414.52406.qmail@web50907.mail.yahoo.com>
Date: Sun, 19 Sep 2004 23:44:14 -0700 (PDT)
From: Linux Guy <kernelx001@yahoo.com>
Subject: bug in fealnx kernel module <network>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Realteck 8139 PCI fst ethernet adapter. It
uses the fealnx kernel module.

I have problems changing the mac address.

normally after boot it works correctly. but after i
change the mac address it doesnt respond.

$ping xxx.xxx.xxx.xxx
<ping reply>
$ifconfig eth0 down
$ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx
$ifconfig eth0 up
$ping xxx.xxx.xxx.xxx
<network host unreachable>

This is very wierd. I had a dlink lan card and it used
to work properly after changing the mac address. 

Anyone knows why Realtek cards dont work after
changing mac address...

I have test this on a gentoo (2.6.7 kernel), slackware
(2.4.26 kernel), knoppix live cd, pclinuxos live cd.

Cya.




		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
