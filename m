Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271011AbRIHVAD>; Sat, 8 Sep 2001 17:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271138AbRIHU7x>; Sat, 8 Sep 2001 16:59:53 -0400
Received: from munch.iskp.uni-bonn.de ([131.220.220.83]:6148 "EHLO
	munch.iskp.uni-bonn.de") by vger.kernel.org with ESMTP
	id <S271011AbRIHU7k> convert rfc822-to-8bit; Sat, 8 Sep 2001 16:59:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Harald van Pee <pee@iskp.uni-bonn.de>
Organization: Uni-Bonn
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre10 seems to be very unstable with raid 0 and nfs
Date: Sat, 8 Sep 2001 22:59:55 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090822595500.22683@munch>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm not subscribed to the list, but maybe this information can help you to 
check your code.

I have tried to use linux raid 0.9 with kernel 2.4.9-ac9. 
This is on a Asus A7V266 with two ide disks at the VIA vt8233 ide controler, 
NIC Realtek 8139too.

Everything works fast and stable, but if I read files remotly I got very 
often: 
Stale NFS file handle.

With 2.410.pre5 I don't see this message any longer, but the machine freezes 
completly after a few minutes while I'm reading from remote (no messages in 
the logfile).

Regards
Harald
