Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTLDUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLDUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:23:59 -0500
Received: from smtp.terra.es ([213.4.129.129]:62767 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S263487AbTLDUX6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:23:58 -0500
Date: Thu, 4 Dec 2003 21:23:35 +0100
From: "grundig@teleline.es" <grundig@teleline.es>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
Message-Id: <20031204212335.6ec1854c.grundig@teleline.es>
In-Reply-To: <20031204135415.GA9913@shookay.newview.com>
References: <20031204135415.GA9913@shookay.newview.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 4 Dec 2003 08:54:15 -0500 Mathieu Chouquet-Stringer <mathieu@newview.com> escribió:

> 	Hi all,
> 
> I just tried the latest 2.6.0 (test11) on a Dell 410 (a bi-PIII) and the
> SMP flavor of this kernel doesn't work at all. The non-smp one works well
> (so I know it's not a case of VT/VGA console missing).
> 
> It dies (without any error message) after this:
> Uncompressing Linux... Ok, booting the kernel
> 
> I tried disabling APIC in the BIOS but it doesn't make any difference...
> 
> Any idea?

There's some bugs for other dell spm machines in the bugzilla, don't know
it it's related but....
http://bugzilla.kernel.org/show_bug.cgi?id=1379
http://bugzilla.kernel.org/show_bug.cgi?id=1434

