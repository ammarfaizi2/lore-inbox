Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280707AbRK1VPY>; Wed, 28 Nov 2001 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRK1VPQ>; Wed, 28 Nov 2001 16:15:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29848 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280707AbRK1VPL> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 16:15:11 -0500
Date: Wed, 28 Nov 2001 13:15:03 -0800 (PST)
Message-Id: <20011128.131503.22504634.davem@redhat.com>
To: groudier@free.fr
Cc: matthias@winterdrache.de, linux-kernel@vger.kernel.org
Subject: Re: sym53c875: reading /proc causes SCSI parity error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011128184622.N2255-100000@gerard>
In-Reply-To: <3C053AF2.10037.4CCE47@localhost>
	<20011128184622.N2255-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 28 Nov 2001 19:14:52 +0100 (CET)
   
   This is a known issue that had been discussed in time, but no fix had been
   considered worth to be applied by PCI et co maintainers.

Why not just put some bitmap pointer into the pci device
struct.  If it is non-NULL, it specifies PCI config space
areas which have side-effects.
