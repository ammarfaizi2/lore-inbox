Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRKFIpW>; Tue, 6 Nov 2001 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278673AbRKFIpN>; Tue, 6 Nov 2001 03:45:13 -0500
Received: from isp01.net ([209.90.125.207]:11795 "HELO itc.prohosting.com")
	by vger.kernel.org with SMTP id <S278660AbRKFIo7>;
	Tue, 6 Nov 2001 03:44:59 -0500
Subject: TCP Connections stuck in SYN_SENT state with 2.4.12, 2.4.13, 2.4.14
From: "James A. Hillyerd" <james@hillyerd.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.34 (Preview Release)
Date: 06 Nov 2001 00:44:00 -0800
Message-Id: <1005036240.978.6.camel@makita>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange problem, outgoing TCP packets get stuck at the SYN_SENT
point for certain websites.  Two of the sites I have this problem with
are zdnet.com and compusa.com.  When I try to telnet to port 80, the
connection will never be established, and netstat shows it in the
SYN_SENT state.

This problem occurs with kernels 2.4.12-2.4.14.  It does not occur with
2.4.10.  I am making these connections via a PPP link, but a friend of
mine has duplicated the exact same problem using a ethernet connection
(passing over DSL).  We do not have the same ISP, so I don't think that
is the problem.

Any help, or requests for more debugging info would be appreciated. 
Please CC message to me, I am not subscribed to the list.

Thanks.

-james

-- 
[]  James A. Hillyerd <james@hillyerd.com> - Java Developer
[]  PGP 1024D/D31BC40D F87B 7906 C0DA 32E8 B8F6 DE23 FBF6 4712 D31B C40D

