Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318084AbSGMBSb>; Fri, 12 Jul 2002 21:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSGMBSa>; Fri, 12 Jul 2002 21:18:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63149 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318084AbSGMBS3>;
	Fri, 12 Jul 2002 21:18:29 -0400
Date: Fri, 12 Jul 2002 18:12:14 -0700 (PDT)
Message-Id: <20020712.181214.15590856.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1026527009.9958.69.camel@irongate.swansea.linux.org.uk>
References: <20020713003601.GA12118@kroah.com>
	<1026527009.9958.69.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 13 Jul 2002 03:23:29 +0100
   
   I have several examples where the ordering of the PCI cards is critical
   to get stuff like boot device and primary controller detection right.
   pci_register_driver doesn't appear to have a good way to deal with this
   or have I missed something ?

Cards get registered in the order they appear on the bus, or at least
that is the way the algorithm worked the last time I looked.

Or, what other facility do you need?
