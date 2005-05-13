Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVEMSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVEMSiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVEMSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:38:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58314 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262475AbVEMShw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:37:52 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m164xnatpt.fsf@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116009347.1448.489.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 19:35:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a kernel problem, but a user space problem. The fix 
> is to change the user space crypto code to need the same number of cache line
> accesses on all keys. 

You actually also need to hit the same cache line sequence on all keys
if you take a bit more care about it.

> Disabling HT for this would the totally wrong approach, like throwing
> out the baby with the bath water.

HT for most users is pretty irrelevant, its a neat idea but the
benchmarks don't suggest its too big a hit

