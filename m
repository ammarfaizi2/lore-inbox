Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTJJI5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJJI5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:57:32 -0400
Received: from madness.at ([213.153.61.104]:47877 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S262736AbTJJI5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:57:31 -0400
Message-ID: <3F86746C.6040704@madness.at>
Date: Fri, 10 Oct 2003 10:57:16 +0200
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Serverworks CSB5 IDE-DMA Problem (2.4 and 2.6)
References: <Pine.LNX.4.44.0310091634330.3040-100000@logos.cnet> <200310092313.05371.bzolnier@elka.pw.edu.pl> <3F85D17D.2090006@madness.at> <200310092329.00445.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310092329.00445.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 2.4.18, 2.4.19 w/o APIC and ACPI

ok 2.4.18 (dmesg at http://www.kaltenbrunner.cc/files/dmesg2418.txt) 
seems to work better(although not as fast as I would like to have it) 
but I suspect that:

ide1: Speed warnings UDMA 3/4/5 is not functional.
ide0: Speed warnings UDMA 3/4/5 is not functional.

is quite interesting - if these UDMA-modes do not work reliable - why do 
they get enabled with later kernels(not that I would have a problem with 
getting UDMA > 2 working *g*) ?


Stefan

