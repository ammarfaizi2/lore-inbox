Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTJQWJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTJQWJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:09:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261176AbTJQWJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:09:16 -0400
Message-ID: <3F90687E.8030601@pobox.com>
Date: Fri, 17 Oct 2003 18:09:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Wong <kernel@implode.net>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000.
 (fwd)
References: <Pine.LNX.4.44.0310171852330.12627-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310171852330.12627-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 16 Oct 2003 12:27:17 -0700
> From: John Wong <kernel@implode.net>
> To: linux-kernel@vger.kernel.org
> Subject: via-rhine on 2.4.23-pre6 Too much work at interrupt,
>      status=0x00001000.
> 
> The system used to run 2.4.22 and did not have this too much work
> problem.  There were some other hardware changes.  The system used to be
> a Pentium 100 on a Triton 430FX chipset Intel Advanced/EV board.  Now it 
> is a K6 2 - 500 on a Via Apollo MVP3 chipset on FIC VA-503+ board.
> The NIC stayed the same.  The kernel was recompiled and ACPI was
> enabled.
> 
> I noticed in 2.4.23-pre2 -> pre3
> 	 [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840


This cset contains no functional via-rhine changes...  First thing to do 
would be try to 2.4.23-pre2.  But my main suspect would be ACPI.

	Jeff


