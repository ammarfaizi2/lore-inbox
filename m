Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJNREn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTJNREn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:04:43 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:32921 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S262598AbTJNREl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:04:41 -0400
Date: Tue, 14 Oct 2003 19:04:38 +0200
Message-ID: <3F710B1D00077369@mssbzhh-int.msg.bluewin.ch>
From: marc.kalberer@bluewin.ch
Subject: linux 2.6.0-test7 broadcom driver b44
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Bluewin WebMail / BlueMail
X-Originating-IP: 172.21.1.219
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
After about 30 recompiling of the kernel and svevral research on the net
I came to the result :
the Broadcom driver bcm4400 (b44) has a problem

log:
- Kernel: b44.c:v0.9 (july 2003)
- link is down 
- flow control is off for tx and off for rx

First I wasn't able to do a ifup: it gave me a siocsifflags not implemented
error,
but it disapear when I enable the acpi (??? Strange how those 2 things are
related ??)

Then I tried the patch solution provided by http://twibble.org/dist/bcm4400/
No better result !
I used gcc 3.2.2

I got an other feed back from somebody who installed the 2.4.22, with the
b44 driver and who get a failure on bringing up the network at boot time
but ..... network is strangely working correctly !

I don't know where to find more logs on this specific problem, if you need
some more info, contact me

Marc Kalberer


marc.kalberer@programmers.ch

