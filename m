Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADGeY>; Thu, 4 Jan 2001 01:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADGeO>; Thu, 4 Jan 2001 01:34:14 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:10257 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S129348AbRADGd7>;
	Thu, 4 Jan 2001 01:33:59 -0500
Date: Thu, 4 Jan 2001 01:33:40 -0500
From: Tim Sailer <sailer@bnl.gov>
To: linux-kernel@vger.kernel.org
Subject: Network Performance?
Message-ID: <20010104013340.A20552@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may not be the right forum to ask this. If not, please let me know
where to ask.

I have a Debian box with 2 NICs. Both 100/full duplex. This machine is 
running as a ftp proxy (T.Rex suite). As part of the traffic going through the
box, some streams have 1000k window size for a certain reason. How do
I tune the NICs to handle the streams better? There are ways of doing this
on other OSs. Right now, the box only does about 1.8Mb when it should be doing
80+Mb.

Thanks,
Tim

PS: This is really something to do with the window size and WAN latency.
The ultimate source and destination points are either Solaris or AIX
boxes. The files being sent are > 1GB in size.
The box does well when traffic goes in one NIC and out the other, as long
as the end point is local When it hits the WAN, it all dies. Traffic not
going through the box just flies right along, as long as both the end points
have the large tcp window size. Putting the Linux box in the middle is a 
severe choke point. :(


-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
