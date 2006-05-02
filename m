Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWEBWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWEBWJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWEBWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:09:20 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:45733 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932267AbWEBWJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:09:19 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Tue, 2 May 2006 15:09:16 -0700
User-Agent: KMail/1.7.1
Cc: Michael Helmling <supermihi@web.de>, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de>
In-Reply-To: <200605022002.15845.supermihi@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021509.17050.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 11:02 am, Michael Helmling wrote:
> Hi all,
> 
> I bought an USB-Ethernet adaptor from delock (www.delock.de) and found it was 
> not supported by linux from the vendor. So I played a little with lsusb and 
> found it uses a MCS7830 chip from MosChip semiconductor (moschip.com). On 
> their homepage I found a driver but it only was a precompiled Fedora4 module. 
> So I wrote them an email and they sent me the whole source code for the 
> module...
>
> Would be nice to see this supported in further kernel releases.
> The sourcecode can be found at ftp://supermihi.myftp.org

Was it you who removed the copyrights from the "usbnet" driver and
changed the author assertion to one "M Subrahmanya Srihdar" ??
I'm guessing the latter; the www.moschip.com site implies that
its engineering HW is in India.

Either way, blatant plagiarism and theft of copyright is unlikely
to get into upstream kernels.

Likewise, that is NOT the way to integrate with the "usbnet" driver
framework.  See how it's done by the "asix.c" driver module.


In fact, I'm very tempted to ask them to withdraw their distribution,
since they have clearly violated pretty basic terms of the GPL.  How
long have they been doing that?  How much money have they made by
this theft?

That stuff is correctible ... but until they correct their problems,
I'm not inclined to let them continue distributing stolen software.

- Dave

