Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVDNMBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDNMBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDNMBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:01:22 -0400
Received: from animx.eu.org ([216.98.75.249]:51932 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261480AbVDNMBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:01:20 -0400
Date: Thu, 14 Apr 2005 08:02:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: USB problems 2.6.10
Message-ID: <20050414120236.GA28242@animx.eu.org>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050324130045.GA30623@animx.eu.org> <20050324160225.GA19355@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324160225.GA19355@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Mar 24, 2005 at 08:00:46AM -0500, Wakko Warner wrote:
> > I have a system that I just updated to 2.6 and USB fails to work after some
> > time (~6-8 hours) giving me the "irq 11:nobody cared" message.
> > 
> > This system is a supermicro p3tdde (via chipset)
> > I have ACPI and Preempt enabled (which I will disable and try again)
> > 
> > I notice this rather quickly as my keyboard/mouse are on this controller.  I
> > have an NEC chip USB2.0 card installed which is currently working.
> 
> Can you try 2.6.11 and see if that is better?

I went to 2.6.12-rc2 instead.  So far it seems to be working.  I was unable
to test this until yesterday due to my workload.

The only problem I have now is the fact that my keyboard has 8 extra keys
which only 3 work under 2.6; all 8 keys work fine under 2.4.

I ran showkey -s to verify.  I see no log messages with 2.6.12-rc2 (I did
with 2.6.10)  They keyboard is an HP wireless KBR0133.  It came as a set
with wireless receiver/mouse/keyboard.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
