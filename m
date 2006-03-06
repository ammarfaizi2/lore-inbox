Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWCFXRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWCFXRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCFXRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:17:15 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:13486 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932442AbWCFXRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:17:15 -0500
Message-ID: <440CC29F.2060906@cfl.rr.com>
Date: Mon, 06 Mar 2006 18:15:43 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Benjamin LaHaise <bcrl@kvack.org>, Dan Aloni <da-x@monatomic.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
References: <20060306062402.GA25284@localdomain>  <20060306211854.GM20768@kvack.org> <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
In-Reply-To: <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 23:19:32.0026 (UTC) FILETIME=[6C9391A0:01C64174]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14308.000
X-TM-AS-Result: No--1.600000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> I don't think the POSIX AIO nor the kernel AIO interfaces are suitable
> for sockets, at least the way we can expect network traffic to be
> handled in the near future.  Some more radical approaches are needed. 
> I'll have some proposals which will be part of the talk I have at OLS.


Why do you say it is not suitable?  The kernel aio interfaces should 
work very well, especially when combined with O_DIRECT.

