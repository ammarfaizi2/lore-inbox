Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTFPVfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTFPVfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:35:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40351 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264346AbTFPVfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:35:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Mark Watts <m.watts@mrw.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Xeon  processors &&Hyper-Threading
Date: Mon, 16 Jun 2003 14:49:27 -0700
User-Agent: KMail/1.4.3
References: <3EE9FDFA.6020803@mindspring.com> <Pine.LNX.4.53.0306131241330.5894@chaos> <200306141450.11804.m.watts@mrw.demon.co.uk>
In-Reply-To: <200306141450.11804.m.watts@mrw.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306161449.27121.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 June 2003 06:50 am, Mark Watts wrote:
> > You recompile the kernel for SMP as well as P4. If the motherboard
> > hasn't disabled HT capabilities, you will take full advantage of
> > the processor under Linux. Whatever "full advantage" means, is
> > not absolute, but whatever it is, will be used to its fullest.
> > Basically, if the code is I/O bound, you'll not see any difference.
> > If the code is compute-intensive, you will.
>
> I discovered that you need the 'CPU Enumeration' part of ACPI to be enabled
> otherwise the kernel only sees physical processors, not sibling HT
> processors - shouldnt this be selected automatically when you select SMP ?
> -

Not if you have enabled full ACPI, or if you don't have any P4s.  Some folks 
don't want any ACPI in their kernel at all.   8^)

It's possible for 'CPU Enumeration Only' to be turned on auto-magically, but 
no one has written comprehensive enough logic into the config code, yet....

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

