Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVCDAxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVCDAxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVCDAtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:49:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36825 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262724AbVCDAqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:46:04 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Greg KH <greg@kroah.com>, Chris Friesen <cfriesen@nortel.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304001930.GF30616@zip.com.au>
References: <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <42274171.3030702@nortel.com> <20050303165940.GA11144@kroah.com>
	 <1109893901.21780.68.camel@localhost.localdomain>
	 <20050304001930.GF30616@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109897041.21781.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 00:44:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 00:19, CaT wrote:
> Working IDE locking? Does this mean if I have 2 promise cards, a HD
> on each card and I copy from one to the other it wont all blow up in my
> face?

Depends on your PCI bus and also if the are on the same IRQ. In the same
IRQ case you may find 2.6.11 is a bit saner as Bartlomiej may have
sorted one of the IRQ masking problems now.

