Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbRFUHsc>; Thu, 21 Jun 2001 03:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbRFUHsX>; Thu, 21 Jun 2001 03:48:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:34579 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264925AbRFUHsN>; Thu, 21 Jun 2001 03:48:13 -0400
Message-ID: <3B31A652.85D2E597@idb.hist.no>
Date: Thu, 21 Jun 2001 09:46:26 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.6pre iptables masquerading seems to kill eth0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a home network with two machines connected with
3c905B cards.  The main machine also has a isdn dialup connection.

Networking works well except if I let the main machine masquerade
so the other can use the internet too.  I use iptables for this.
It works for a day or so, then eth0 goes silent on the main machine.
(Rebooting it shows that the other one was fine all the time.)

The symptoms is that there is no contact between the two machines.
No ping or anything.  "ifconfig" shows the interface is up
with the correct ip address, but all packets just disappear.
There are no error messages except from programs that time out.

Bringing the interface down and up
again with ifconfig does not help.  It is compiled into the
kernel, so I can't try module reloading.

Is this some sort of known problem? Or is there something
I could do to find out more?  I couldn't
find anything in the logfiles.

Helge Hafting.
