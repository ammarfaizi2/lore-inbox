Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270295AbRHHDgi>; Tue, 7 Aug 2001 23:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269451AbRHHDg2>; Tue, 7 Aug 2001 23:36:28 -0400
Received: from cs.utexas.edu ([128.83.139.9]:17315 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S270295AbRHHDgK>;
	Tue, 7 Aug 2001 23:36:10 -0400
Date: Tue, 7 Aug 2001 22:36:21 -0500 (CDT)
From: Kalpesh Shah <kalpesh@cs.utexas.edu>
To: <linux-kernel@vger.kernel.org>
Subject: mss on linux 2.2.19
Message-ID: <Pine.LNX.4.33.0108072231460.21594-100000@viper.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wish to be CC'ed on the answers/comments to my response.

I am doing research in TCP-congestion control for one of my classes. I
have been running a client server http experiment on my network.
I tried running the server code  on my private research  network and
client code on one of the local networks.
  In order to trace the traffic i had let TCPdump run on the server port.
After collecting the results i got some unexpected results.
  The MSS(maximum segment size)  on the local network machine(client) was
just 4  and the MSS for my machine was just 8.
  Both these machines are running Debian Linux (kernel version 2.2.19). I
tried looking for the deafult MSS value in the /proc area but it wasnt
there.
  I checked for it in /proc/sys/net/ipv4/route but it was not there..

  Could anyone tell  me if there is any other way to locate  a systems
MSS and change it ?

And also what is the general default MSS on Debian Linux ?

kalpesh




