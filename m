Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTE0DSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTE0DSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:18:34 -0400
Received: from kaneda.boo.net ([216.200.67.189]:30691 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S262985AbTE0DSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:18:34 -0400
Message-Id: <5.2.1.1.2.20030526232835.00a468e0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 26 May 2003 23:37:04 -0400
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 >the system could boot without DMA. It displayed lots of messages, but it 
seems
 >to work :

 >So it seems as the IDE problem is in the ALI 1543 / DMA code. I have an old
 >K6/2 notebook somewhere with the same IDE controller, so I may retry on it.
 >
 >I'm interested in any suggestion, of course ;-)

I have the same system and run into the same problems here. The HD is a
Fujitsu MPD3108AT (10GB ATA33/66 drive, what the machine shipped with)
on hda. Even with the 2.4.21-rc4 kernel, the machine will not boot beyond
the "attached ide-disk driver" message if IDE DMA is compiled in.

Whatever's going wrong doesn't require an older drive to show up.

Let me know how I can help,
jasonp

