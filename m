Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUGKCaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUGKCaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUGKCaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:30:19 -0400
Received: from fmr02.intel.com ([192.55.52.25]:25217 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S266482AbUGKCaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:30:16 -0400
Subject: Re: Fatal problem, possibly related to AIC79xx
From: Len Brown <len.brown@intel.com>
To: Antonin Kral <A.Kral@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFBBF@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFBBF@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089513010.32034.36.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:30:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-10 at 11:21, Antonin Kral wrote:

> SuperMicro X5DL8-GG with aic7902
> ... one XEON 3.06GHz
> 
> I have two, really strange problems, first of all I have noticed, that
> with enabled SMP support kernel detects TWO processors, but only one
> is physically installed.

If you'd like to have just 1 processor instead of two, then
enter the BIOS SETUP and disable HyperThreading (HT),
or boot the SMP kernel with maxcpus=1.

I have no insight into your potential AIC79XX problem...

cheers,
-Len


