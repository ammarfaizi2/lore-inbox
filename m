Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTFBRYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbTFBRYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:24:21 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:51163 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S264796AbTFBRYU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:24:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: impact of Athlon's slower front-side-bus (FSB)
Date: Mon, 2 Jun 2003 14:36:24 -0400
User-Agent: KMail/1.4.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200306020947.44520.jbriggs@briggsmedia.com> <1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306021436.24029.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. You would probably want to tie different cards/encoders to
> different processors and the IRQ to the same one. You can do this via
> /proc and with the -ac or most vendor trees (and 2.5) you can tie
> processes to CPUs with syscalls

Can I do this with the 2.4.19 kernel (debian)?  The cards in question are quad 
bt878 frame grabbers. How specifically can I tie a particular bt878 to a 
particular processor on the dual athlon platform?  

One last question, given the slow FSB and the fact that 2 uP's are groping for 
the same memory space and that each bt878 is dma'ing its data to memory, is 
the SMP still a better idea than uni-processor?

Thanks for all of the help!
-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
