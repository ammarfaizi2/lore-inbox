Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbTCRQXd>; Tue, 18 Mar 2003 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbTCRQXd>; Tue, 18 Mar 2003 11:23:33 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:11661 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S262547AbTCRQXc>;
	Tue, 18 Mar 2003 11:23:32 -0500
Date: Tue, 18 Mar 2003 17:34:27 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.20] Ask for advice: problems with 3Ware controller
Message-ID: <20030318163427.GA19326@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have problems with 3ware Escalade 7500-8 controller under 2.4.20
kernel. Time to time I've found some processes in 'D' state and I've
found in the dmesg this messages:

3w-xxxx: scsi0: Unit #0: Command (f7a68c00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a64a00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a71a00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a65200) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a63200) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a67a00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a6ea00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a7a400) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a6be00) timed out, resetting card.
3w-xxxx: scsi0: Unit #0: Command (f7a65400) timed out, resetting card.

Please, can anyone advice me, what happends? It's problem in the 3ware
board, have I use newer firmware on it... ? Can I do somethink with this
behavior?

Info from /proc interface:

/proc/scsi/3w-xxxx# cat 0
scsi0: 3ware Storage Controller
Driver version: 1.02.00.031
Current commands posted:         0
Max commands posted:           255
Current pending commands:        0
Max pending commands:            0
Last sgl length:                 1
Max sgl length:                 32
Last sector count:               8
Max sector count:              256
Resets:                          0
Aborts:                        1365
AEN's:                           0

Thank you for any advices...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
