Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSIKAhm>; Tue, 10 Sep 2002 20:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSIKAhm>; Tue, 10 Sep 2002 20:37:42 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:26614
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318266AbSIKAhk>; Tue, 10 Sep 2002 20:37:40 -0400
Subject: IDE status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 01:45:45 +0100
Message-Id: <1031705145.2768.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok the last -ac seems to have worked better than I had expected. I've
now got the test code with some more PCI cleanups. I need to finish
pushing these to the other drivers in the PCI layer and then I'll put
out another release

You can now do

hdparm -t /dev/hda           (get 900K/sec)
insmod piix
hdparm -d 1 /dev/hda
hdparm -t /dev/hda           (get 8Mbyte/sec)

[Yeah my TP600 drive isnt the fastest on earth]

