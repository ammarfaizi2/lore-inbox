Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264376AbRFIQ5b>; Sat, 9 Jun 2001 12:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFIQ5V>; Sat, 9 Jun 2001 12:57:21 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:25768 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S264376AbRFIQ5H>; Sat, 9 Jun 2001 12:57:07 -0400
Date: Sat, 9 Jun 2001 18:56:24 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Keith Owens <kaos@ocs.com.au>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: missing symbol do_softirq in net moduels for pre-2
Message-ID: <20010609185624.A689@flodhest.stud.ntnu.no>
Reply-To: tlan@stud.ntnu.no
In-Reply-To: <01060911075200.00993@oscar> <16339.992103452@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16339.992103452@ocs4.ocs-net>; from kaos@ocs.com.au on Sun, Jun 10, 2001 at 02:17:32AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens:
> >Built -pre2 and noticed most of the modules in net/* are getting
> >a missing symbol for do_softirq.  
> http://www.tux.org/lkml/#s8-8

I got the same error on -pre1, and tried the info in the link, didn't help:

root@test4:/usr/src# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.6-pre1/kernel/net/ipv4/netfilter/ip_tables.o
depmod:         do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.6-pre1/kernel/net/ipv4/netfilter/ipt_LOG.o
depmod:         do_softirq

Am I missing something in my .config, or is there something else that's
wrong? Any clues to where I should look?

-- 
-Thomas
