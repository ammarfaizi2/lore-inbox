Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbTCWJEN>; Sun, 23 Mar 2003 04:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbTCWJEN>; Sun, 23 Mar 2003 04:04:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60611 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262987AbTCWJEM>;
	Sun, 23 Mar 2003 04:04:12 -0500
Date: Sun, 23 Mar 2003 01:13:09 -0800 (PST)
Message-Id: <20030323.011309.81687153.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] nicstar doesnt count all dropped pdus (and
 powerpc fixup)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303211650.h2LGoAGi002595@locutus.cmf.nrl.navy.mil>
References: <200303211650.h2LGoAGi002595@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Fri, 21 Mar 2003 11:50:10 -0500

   these two issues with the nicstar have annoyed for some time now.  i
   have a powerpc platform and the +=KERNELBASE doenst work/make sense.
   pci_resource_start() should take care of this if necessary.  the
   second gripe, when atm_charge() fails, you need to count the pdu you
   are about to drop.

Patch applied, thanks Chas.
