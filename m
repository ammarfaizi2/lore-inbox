Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSIFMfG>; Fri, 6 Sep 2002 08:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318552AbSIFMfG>; Fri, 6 Sep 2002 08:35:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318542AbSIFMfF>; Fri, 6 Sep 2002 08:35:05 -0400
Date: Fri, 6 Sep 2002 08:41:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@mwaikambo.name>
cc: Andreas Dilger <adilger@clusterfs.com>,
       Peter Surda <shurdeek@panorama.sth.ac.at>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime timer-wrap
In-Reply-To: <Pine.LNX.4.44.0209061447390.1116-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.3.95.1020906083954.3240A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Zwane Mwaikambo wrote:

> On Fri, 6 Sep 2002, Richard B. Johnson wrote:
> 
> > Do you have an idea where to look? I need to prevent the possibility
> > of waiting forever for an event that may never occur, with interrupts
> > disabled, on at least one embedded system. Any wait-forever possibility
> > must be interruptible because any watch-dog timer that re-boots will end
> > up destroying data that must never be lost.
> 
> Remove the 'wait forever' (really if you're waiting forever you have a 
> bug anyway, be it hardware or otherwise) and break the entire kernel? Or 
> perhaps sprinkle timeouts in every little crevice of the kernel code.
> 
> 	Zwane

The kernel is waiting forever as previously shown.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

