Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSGJLo0>; Wed, 10 Jul 2002 07:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGJLoZ>; Wed, 10 Jul 2002 07:44:25 -0400
Received: from [217.156.100.201] ([217.156.100.201]:42129 "EHLO
	users.blastcenter.com") by vger.kernel.org with ESMTP
	id <S315629AbSGJLoZ>; Wed, 10 Jul 2002 07:44:25 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gogu Mihai <gogu@firexnet.ro>
To: linux-kernel@vger.kernel.org
Subject: Full-Duplex realtek 8029 ehernet card
Date: Wed, 10 Jul 2002 14:48:22 +0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207101448.22679.gogu@firexnet.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux experts,

I don`t know i a came to the right place.

I need a little help. On my router i have 2 ethernet cards Realtek 
8029/bnc+utp.

I read the documentation found on 
http://www.scyld.com/network/ne2k-pci.html and according to this i 
configured:

cat /etc/modules.conf
alias eth0 ne2k-pci
options ne2k-pci full_duplex=1
alias eth1 ne2k-pci
options ne2k-pci full_duplex=1

The problem is that i don`t know with this settings my ethenets works in 
full duplex mode. How can i check?

I compilled and executed as root: ./net2k-pci-diag -a and i saw that 
booth cards are still in half-duplex!

Are my settings correct or no. If no, what else i can do.

Any suggestion will be appreciatted.

Mihai

