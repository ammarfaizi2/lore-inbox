Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRGaSqe>; Tue, 31 Jul 2001 14:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269414AbRGaSqV>; Tue, 31 Jul 2001 14:46:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26637 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269412AbRGaSqJ>;
	Tue, 31 Jul 2001 14:46:09 -0400
Date: Tue, 31 Jul 2001 19:46:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
Message-ID: <20010731194615.B22632@flint.arm.linux.org.uk>
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com> <000701c119cd$ebf0c720$294b82ce@connecttech.com> <20010731174247.A21802@flint.arm.linux.org.uk> <00c001c119e4$31418560$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c001c119e4$31418560$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, Jul 31, 2001 at 01:14:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 01:14:01PM -0400, Stuart MacDonald wrote:
> There seems to be a serial console interface; perhaps we need
> a general console interface that other code can make use of.
> That might pave the way for an ethernet console, or a usb console,
> etc.

We already have a generic console interface - struct console.  Really,
the code between the various serial drivers isn't all that big once
you factor out the setup (which I've already done, including support
for consoles up to 460800 baud).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

