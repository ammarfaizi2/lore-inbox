Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbTDFORi (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTDFORi (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:17:38 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:51888 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262972AbTDFORh (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:17:37 -0400
Date: Mon, 7 Apr 2003 00:27:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poweroff problem
Message-Id: <20030407002703.16993dc4.sfr@canb.auug.org.au>
In-Reply-To: <20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	<20030406233319.042878d3.sfr@canb.auug.org.au>
	<20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003 15:58:14 +0200 "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
>
> It's not a BIOS problem here. halt works pretty well with Linux-2.5.66 here.
> It's most likely an ACPI problem. What happens here is that the code to power
> down actually does not manage to turn the machine off, instead after a while
> the NMI watchdog kicks in and the kernel oopses.

I was asuming the original report was from a kernel using APM not ACPI.
Did 2.4.2 have ACPI?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/   APM Maintainer
