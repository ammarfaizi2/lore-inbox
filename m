Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVBCQUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVBCQUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbVBCQUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:20:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33927 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263638AbVBCQUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:20:14 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zan Lynx <zlynx@acm.org>
Cc: Greg KH <greg@kroah.com>, Pavel Roskin <proski@gnu.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107406442.23059.16.camel@localhost>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
	 <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
	 <20050202232909.GA14607@kroah.com>
	 <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain>
	 <20050203003010.GA15481@kroah.com>  <1107406442.23059.16.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107431398.14847.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Feb 2005 15:12:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-02-03 at 04:54, Zan Lynx wrote:
> So, what's the magic amount of redirection and abstraction that cleanses
> the GPLness, hmm?  Who gets to wave the magic wand to say what
> interfaces are GPL-to-non-GPL and which aren't?

The "derivative work" distinction in law, which can be quite complex
because it involves issues like intent. Other than the intentional clear
statement that the syscall interface is considered a barrier by the
authors there is no other statement.

The GPL grants of patents are having a similar effect too, you'll need a
patent license from IBM to write RCU using code for example unless its
free software.

You also appear to misunderstand dual licensing. If you have a GPL/BSD
dual licensed module then when its using GPL'd code it ends up a
combined GPL work you can't add binary blocks too (except as per being
"not a derivative work")

Alan

