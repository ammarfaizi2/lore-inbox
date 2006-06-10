Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWFJFed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWFJFed (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWFJFed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:34:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:65284 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932396AbWFJFec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:34:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YfrJc1+T74qjqFduwbAW9DVTS32upE971TcNfQp74Lp4eGJc67KTFUogbK/KIMLscT0K6gn3L0SLg2tPm2N/XRcpN8ikN35gLtw+oL8jnKbDYF8/oYSV+B48NUkDNCmTojiaJn9zpr32Z0AQPFIVKoMcLoz8yXfvFSQ9Wn5gfrA=
Message-ID: <a44ae5cd0606092234k70f92bfajb359a9e0c09db3b9@mail.gmail.com>
Date: Sat, 10 Jun 2006 01:34:31 -0400
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-rc6-mm1 -- BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
 [<c0103999>] show_trace_log_lvl+0x53/0xff
 [<c0103ff1>] show_trace+0x16/0x19
 [<c0104037>] dump_stack+0x1a/0x1f
 [<f9295ade>] get_phy_reg+0x77/0xe4 [ohci1394]
 [<f9295e66>] ohci_devctl+0x49/0x56c [ohci1394]
 [<f9298e82>] ohci_irq_handler+0x329/0x720 [ohci1394]
 [<c01435cd>] handle_IRQ_event+0x18/0x4d
 [<c01443fb>] handle_fasteoi_irq+0x57/0x95
 [<c01050bf>] do_IRQ+0xa1/0xc6
 [<c0103475>] common_interrupt+0x25/0x2c
BUG: warning at drivers/ieee1394/ohci1394.c:264/set_phy_reg()
 [<c0103999>] show_trace_log_lvl+0x53/0xff
 [<c0103ff1>] show_trace+0x16/0x19
 [<c0104037>] dump_stack+0x1a/0x1f
 [<f9295a14>] set_phy_reg+0x84/0xd7 [ohci1394]
 [<f9295e79>] ohci_devctl+0x5c/0x56c [ohci1394]
 [<f9298e82>] ohci_irq_handler+0x329/0x720 [ohci1394]
 [<c01435cd>] handle_IRQ_event+0x18/0x4d
 [<c01443fb>] handle_fasteoi_irq+0x57/0x95
 [<c01050bf>] do_IRQ+0xa1/0xc6
 [<c0103475>] common_interrupt+0x25/0x2c
