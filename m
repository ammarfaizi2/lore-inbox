Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTILO4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTILO4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:56:13 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:37323 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261712AbTILO4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:56:10 -0400
Message-ID: <00db01c3793d$e22aaf40$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>, "Dan Behman" <dbehman@ca.ibm.com>
References: <OFACE20891.664CABA8-ON85256D9F.004FBBDE@torolab.ibm.com>
Subject: Re: Hyperthreading: easiest userland method?
Date: Fri, 12 Sep 2003 16:55:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Have you checked x86info ? http://www.codemonkey.org.uk/projects/x86info/

You may ask Dave Jones to add a single option that could never change, and
returns TRUE or FALSE, depending on HT enabled CPUS.


From: "Dan Behman" <dbehman@ca.ibm.com>
> Hi,
>
> I have a need to programmatically determine whether or not hyperthreading
> is enabled (and in use) for licensing reasons in my application.
> Currently, I know of two ways to do this:
>
> 1) parse /proc/cpuinfo for "processor id"
> 2) port Intel's documented method (written for Windows) to directly query
> the CPUs
>
> Both methods have drawbacks - 1) relying on specific text that could
change
> is a bad idea; 2) this doesn't take into account whether or not Linux
> and/or the BIOS is making use of the hyperthreading.
>
> >From scouring the archives and the net, it doesn't seem like there's any
> API that currently exists, but perhaps I've missed something.
> /proc/cpuinfo gathers its information from somewhere - is there a way in
> userland to bypass /proc/cpuinfo and directly get this data manually?
>
> I'm interested in both 2.4 and 2.6 implementations and would like to be
> personally CC'ed on any repsonses.
>
> Thanks in advance!
>
> Dan Behman.
> IBM Canada Ltd.

