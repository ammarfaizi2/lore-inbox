Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWBFQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWBFQuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWBFQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:50:21 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:57871 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S932211AbWBFQuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:50:21 -0500
Date: Mon, 6 Feb 2006 17:50:14 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060206165014.GC31314@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <200602051145.22933.david-b@pacbell.net> <20060206080251.GA23014@epio.fluido.as> <200602060824.04945.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200602060824.04945.david-b@pacbell.net>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: Mon 06 Feb 06 08:24:04AM -0800

Quoting David Brownell (david-b@pacbell.net):

> If it printed that, then how is it possible that it hung _before_ printing
> that message???

I already wrote that I had commented out the line that caused the
hangup:

//			pci_write_config_byte(pdev, offset + 3, 1);

After commenting out this line, the machine boots OK and EHCI works
fine. It does print the BIOS handoff failed message. 

If I do not comment out the above line, the machine hangs, and,
obviously, no BIOS handoff failed message is printed.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
