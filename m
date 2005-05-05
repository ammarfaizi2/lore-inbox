Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVEEVhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVEEVhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVEEVhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:37:51 -0400
Received: from khc.piap.pl ([195.187.100.11]:30468 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261943AbVEEVhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:37:47 -0400
To: Rick Warner <rick@microway.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: very strange issue with sata,<4G Ram, and ext3
References: <200504281216.08026.rick@microway.com>
	<1114728503.24687.248.camel@localhost.localdomain>
	<200504291045.58893.rick@microway.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 05 May 2005 23:37:43 +0200
In-Reply-To: <200504291045.58893.rick@microway.com> (Rick Warner's message
 of "Fri, 29 Apr 2005 10:45:58 -0400")
Message-ID: <m364xxtkuw.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Warner <rick@microway.com> writes:

> This morning, we tried updating to a newer pxelinux (3.07) and had the same 
> results.  We then tried using etherboot with a mknbi tagged image and also 
> had the same results.   Since we are getting the same problem on 3 different 
> motherboards with 2 different network adapters, I have not looked into 
> updating the boot rom on the nics.  Should I?

I remember I had memory corruption problems with an old version of
Etherboot few years ago. The machines were mostly AMD K6 based,
network cards were SMC EPIC100 (Etherpower II) and/or RTL 8139.

Memtest86 (downloaded with Etherboot) complained about random errors.
I think Linux didn't show any such illness.
This was Etherboot 4.something. Upgrading to 5.something fixed the
problem.

I suspect you're using Etherboot newer than 4.x though. I'd probably
give memtest86 loaded from network a try.
-- 
Krzysztof Halasa
