Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbRE1SNL>; Mon, 28 May 2001 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbRE1SNB>; Mon, 28 May 2001 14:13:01 -0400
Received: from hamachi.synopsys.com ([204.176.20.26]:7064 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S261595AbRE1SMr>; Mon, 28 May 2001 14:12:47 -0400
Message-ID: <3B129510.53197DDB@Synopsys.COM>
Date: Mon, 28 May 2001 20:12:32 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.5: SCSI devices are mixed up?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

It took me quite some time to recognize what has changed between 2.4.4
and 2.4.5 and why my CD drives were not accessable: Somehow the sequence 
of SCSI devices has been changed.

For 2.4.4 the IDE SCSI emulation was scsibus0, my Adaptec 39160 was 
scsibus1 and scsibus2.

Suddenly with 2.4.5 the IDE SCSI stuff is scsibus2. The Adaptec devices
moved down one step. You can imagine that this mixed up a lot of things. 
Fortunately my boot disk wasn't affected. 

My question is: How can I specify the sequence of the SCSI devices?
I would like to make sure that this doesn't happen again.


Regards

Harri
