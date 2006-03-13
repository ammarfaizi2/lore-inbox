Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWCMV6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWCMV6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCMV6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:58:13 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:53776 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932472AbWCMV6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:58:11 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mr.fred.smoothie@gmail.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Mon, 13 Mar 2006 13:57:41 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEAJKLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <161717d50603130816u1d63caa1j432d00dd5c54e454@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 13:53:54 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 13:53:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> In Static Controls, the issue was a 55 byte program to calculate the
> level of toner in a cartridge. The court ruled that the program design
> of the TLP was so constrained by external factors (the efficient
> execution of a small number of calculations) that any other
> implementation would have been impractical.

	Exactly. And this is precisely what is happening here. The kernel headers
are small in comparison to the kernel. And external factors are such that
there is no other way to create kernel modules other than by using the
kernel headers.

> Linux is a completely different matter, directly analogous to Apple's
> OS in the court's analysis. There are no such external factors
> dictating the form of the kernel's facilities for integrating new
> functionality.

	You are saying there are practical ways to develop kernel modules other
than using the kernel headers?

> The kernel developers could have chosen some other
> means for drivers to coordinate their activities with the kernel than
> the current driver model (for instance, the means employed in Linux
> 2.4).

	Sure, and Lexmark could have allowed the TLP to be a million bytes.

> You keep insisting that "a driver for hardware X under Linux" is a
> functional idea. It is not. "Calculate the amount of toner left" is a
> functional idea. "Set the control register of hardware X to value Y"
> is a functional idea (and not copyrightable due to scenes a faire).

	If that was true, then why didn't the court say to Static Controls
"calculate the toner left on some other printer, you cannot take the TLP"?

> To conflate
> the two as you seem to want to do would render pretty much all
> software uncopyrightable. That might be preferable to you, but it
> would crush innovation in software development and make it impossible
> for anyone but largish businesses to create software.

	Not at all. The only case where software is uncopyrightable is when it
claims to cover *every* practical way to make X do Y with Z. Just as the TLP
was the only (practical) way to measure the toner left in particular Lexmark
printers.

	DS


