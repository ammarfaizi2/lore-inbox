Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbRBUNpn>; Wed, 21 Feb 2001 08:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBUNpe>; Wed, 21 Feb 2001 08:45:34 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:26894 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129104AbRBUNpZ>;
	Wed, 21 Feb 2001 08:45:25 -0500
Date: Wed, 21 Feb 2001 14:45:22 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Looking for a way to trigger error on network adapter
Message-ID: <20010221144521.A18673@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Context:
HDLC PCI adapter + line at 2 Mb/s + external traffic generator that fills 
the line with 5 to x1000 bytes frame.

I want to see how my code bahaves during rare (?) events: an overflow of 
the RX fifo (256 bytes) and a TX underrun. It's my understanding that if the 
adapter pains at DMAing, those errors should be triggered.
Could I/O at a inocuous location (a well-choosen PCI register ?) be enough 
for that ?

-- 
Ueimor
