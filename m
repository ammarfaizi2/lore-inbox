Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJHUMs>; Tue, 8 Oct 2002 16:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbSJHULd>; Tue, 8 Oct 2002 16:11:33 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:29677 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261441AbSJHTMW>; Tue, 8 Oct 2002 15:12:22 -0400
Message-Id: <4.3.2.7.2.20021008211708.00b4d630@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 08 Oct 2002 21:17:55 +0200
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Build fail 2.5.41-ac1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0xdb49): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0xdb92): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0xdbbe): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0xdd00): undefined reference to 
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.text.init+0x59b): undefined reference to `llc_sap_open'

