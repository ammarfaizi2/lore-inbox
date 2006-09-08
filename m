Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWIHSxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWIHSxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIHSxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:53:24 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:55957 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750804AbWIHSxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:53:23 -0400
Message-ID: <4501BC2B.5040204@cfl.rr.com>
Date: Fri, 08 Sep 2006 14:53:31 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: balagi@justmail.de
CC: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling
 fix
References: <op.tfkmp60biudtyh@master>
In-Reply-To: <op.tfkmp60biudtyh@master>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2006 18:53:31.0686 (UTC) FILETIME=[144E7460:01C6D378]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14678.003
X-TM-AS-Result: No--10.721100-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Maier wrote:
> Hello
> 
> (3th try with fixed inline patch)
> 
> This is a patch for the packet writing driver pktcdvd.
> It adds a sysfs interface to the driver and a bio write
> queue "congestion" handling.
> 

Why does pktcdvd need to handle congestion?  Doesn't it get blocked when 
trying to send down bios to the underlying device if it's queue is 
congested?


