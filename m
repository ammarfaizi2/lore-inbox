Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272889AbRIMG4Y>; Thu, 13 Sep 2001 02:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272897AbRIMG4P>; Thu, 13 Sep 2001 02:56:15 -0400
Received: from motgate4.mot.com ([144.189.100.102]:34995 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id <S272889AbRIMG4D>;
	Thu, 13 Sep 2001 02:56:03 -0400
Message-ID: <3BA05965.559973E9@mihy.mot.com>
Date: Thu, 13 Sep 2001 12:29:49 +0530
From: csaradap <csaradap@mihy.mot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-india-help@lists.sourceforge.net" 
	<linux-india-help@lists.sourceforge.net>,
        "linux-india-programmers@lists.sourceforge.net" 
	<linux-india-programmers@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: slip login
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to configure my slip login , is it possible to have slip
server and client same IP, I mean with slip server assigned IP
192.168.1.1 can I use the same IP to connect to the SLIP
server..Whenever I try to login I get a message like

Lat login on......
starting normal SLIP for user XXX
Your Ip is 192.168.1.1 and your server is 192.168.1.1

The login gets killed immidiately..Before this I am just doing the
following steps..

1> slattach -p slip /dev/ttyS0 &
2>slattach -p slip /dev/ttyS1 &
3>connecting both the serial port with a cable
4>ifconfig sl0 192.168.1.1 pointopoint 192.168.1.1 up



can anyone tell me whether this will work or not....

thanx
ch.s.p.nanda

