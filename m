Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbULZFve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbULZFve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 00:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbULZFve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 00:51:34 -0500
Received: from web51510.mail.yahoo.com ([206.190.38.202]:28273 "HELO
	web51510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261619AbULZFv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 00:51:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=NvbPp0VZ7ieWoJ20sKtFJs/00iBy6kls/2mRJuvWDOxAlEAO8PCLCzeeg3XgmFsnSgIpa8n7It0R5/LJQa8gxPeHCZEX+mF0UCh7REx224dcwZtb51larmXfDKS03nsiKUwYe9JRHz6PPiw9DxK6tB7sVt5Zo1IuB7y1yxNiPvM=  ;
Message-ID: <20041226055129.96662.qmail@web51510.mail.yahoo.com>
Date: Sat, 25 Dec 2004 21:51:29 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Is there any more special purpose sockets in Linux kernel 2.6
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, dave@thedillows.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  As we know, the Linux network component creates two
special purpose sockets for use by the AF_INET
protocol family. The tcp_socket is used to send resets
when a TCP packet is rejected, since there may be no
local socket corresponding to the packet. The
icmp_socket is used to send ICMP messages.

  Now, Is there still only the two special purpose
sockets (i.e. tcp_socket and icmp_socket) in Linux
kernel 2.6 for use by the AF_INET protocol family for
those packets that have no local socket corresponding
to them?
  Do all other packet (which is going to be sent out)
have a local socket corresponding to them
respectively, except those packets which use the above
special purpose sockets? 
  And, as for a packet which is received, Is there a
local socket corresponding to it on the receiving
machine?  

  Thanks in advance.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
