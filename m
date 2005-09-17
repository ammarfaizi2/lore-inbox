Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVIQA7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVIQA7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVIQA7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:59:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39405 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750798AbVIQA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:59:44 -0400
Subject: Re: NTP leap second question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: george@mvista.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <432B3FEB.1070303@mvista.com>
References: <20050914222003.23790.qmail@science.horizon.com>
	 <432B3FEB.1070303@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Sep 2005 02:23:12 +0100
Message-Id: <1126920192.22339.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-16 at 14:58 -0700, George Anzinger wrote:
> What I am asking is when is the flag sent to the kernel.  My reading of 
> the kernel code says that it will insert the second on the second roll 
> immeadiatly after the flag is set.

Kernel clock ticks are not adjusted or slewed or anything else for a
leap second when correctly configured. UTC leap second adjustment is
performed by glibc for locales that expect it (which I think is all of
them)

Alan

