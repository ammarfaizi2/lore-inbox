Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTDOTKf (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTDOTKf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:10:35 -0400
Received: from HDOfa-03p4-85.ppp11.odn.ad.jp ([61.196.10.85]:6099 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S264030AbTDOTKe (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:10:34 -0400
Date: Wed, 16 Apr 2003 04:22:24 +0900 (JST)
Message-Id: <20030416.042224.74745621.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 : oops? when writing to udf
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.0.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I made blank UDF image with mkudffs 1.0.0b2 (Debian) on ext3fs,and 
I mount this image to write files to udf image as below:

# mount -t udf -o loop image.img dvd/

And,when I trying to write latrge (>>100MB) files from ext3fs to this partition,
sometimes freeze kernel.

I don't know what's wrong,but before 2.4.21-pre6, this issue was *not* happened.

Regards,
 Ohta. 
