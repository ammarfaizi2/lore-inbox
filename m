Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbTCNWwp>; Fri, 14 Mar 2003 17:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbTCNWwp>; Fri, 14 Mar 2003 17:52:45 -0500
Received: from APastourelles-108-2-1-3.abo.wanadoo.fr ([80.14.139.3]:12228
	"EHLO mail.two-towers.net") by vger.kernel.org with ESMTP
	id <S261224AbTCNWwo>; Fri, 14 Mar 2003 17:52:44 -0500
Message-ID: <3E725DA5.4070108@free.fr>
Date: Fri, 14 Mar 2003 23:54:29 +0100
From: Philip Dodd <smpcomputing@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI errors in logs
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Running debian testing with 2.4.20 + preempt + bttv kernel patches with 
1GB of RAM - high memory enabled, I get big bunches of the following in 
/var/log/messages.


Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
SE mode
Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
LVD mode
Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
SE mode
Mar 14 20:41:27 gandalf kernel: scsi0: Transceiver State Has Changed to 
LVD mode

On several occasions my logs have been filled with theses messages. 
Adaptec driver is compiled in the kernel, and scsi0 is unused (scsi1 is 
the other channel on my adaptec 39160, scsi2 is ide-scsi).  Nothing is 
physically plugged in to this channel (yet!).

I'd be grateful for any ideas - is this hardware?

Thanks,

Philip

