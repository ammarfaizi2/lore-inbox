Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSIFM0k>; Fri, 6 Sep 2002 08:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSIFM0k>; Fri, 6 Sep 2002 08:26:40 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:53709 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318539AbSIFM0k>; Fri, 6 Sep 2002 08:26:40 -0400
Date: Fri, 6 Sep 2002 14:53:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Peter Surda <shurdeek@panorama.sth.ac.at>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime timer-wrap
In-Reply-To: <Pine.LNX.3.95.1020906075225.3143A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0209061447390.1116-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Richard B. Johnson wrote:

> Do you have an idea where to look? I need to prevent the possibility
> of waiting forever for an event that may never occur, with interrupts
> disabled, on at least one embedded system. Any wait-forever possibility
> must be interruptible because any watch-dog timer that re-boots will end
> up destroying data that must never be lost.

Remove the 'wait forever' (really if you're waiting forever you have a 
bug anyway, be it hardware or otherwise) and break the entire kernel? Or 
perhaps sprinkle timeouts in every little crevice of the kernel code.

	Zwane

-- 
function.linuxpower.ca

