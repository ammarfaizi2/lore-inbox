Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbRBESbS>; Mon, 5 Feb 2001 13:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131396AbRBESbI>; Mon, 5 Feb 2001 13:31:08 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:57096 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131245AbRBESbC>; Mon, 5 Feb 2001 13:31:02 -0500
Date: Mon, 5 Feb 2001 19:32:16 +0100
From: Oliver Feiler <kiza@lionking.org>
To: linux-kernel@vger.kernel.org
Subject: Very high system load writing data to SCSI DVD-RAM
Message-ID: <20010205193216.A198@lionking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I have the following problem with a DVD-RAM drive. The drive is a 
Panasonic LF-D101 connected to a Tekram DC395U SCSI controller. Kernel is 
2.2.18 with the patch for the Tekram controller 
(http://www.garloff.de/kurt/linux/dc395/). 

	When I write huge amounts of data to a DVD-RAM the system load is 
getting very high, like 10 or even above and the system temporarily freezes 
for a short time every minute or so while writing data to the drive. The DVD 
drive writes data with 1.35 MB/sec on the discs so there is not really much 
data going over the SCSI controller. Reading data from DVD-RAMs is done with 
2.7 MB/s (2x) by the drive and does not cause any problems at all.

	This problem also existed with previous kernels (2.2.16/17) and with 
another SCSI controller I had before the Tekram. Adaptec 2904CD using the 
aic7xxx driver.

	There is a 4x Teac burner connected to the SCSI controller as well. 
Burning CDs does not raise the system load or cause any other problems.

Bye,
Oliver

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
