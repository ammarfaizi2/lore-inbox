Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbUKEDON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbUKEDON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUKEDON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:14:13 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:10440 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262582AbUKEDN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:13:59 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Tim Connors <tconnors+linuxkernel1099624161@astro.swin.edu.au>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 21:17:23 -0600
User-Agent: KMail/1.7
Cc: Elladan <elladan@eskimo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org, M?ns Rullg?rd <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <20041105023850.GC17010@eskimo.com> <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411042117.23505.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 21:10, Tim Connors wrote:

> Of course, it's not necessarily a bug. Someone could have just kicked
> the ethernet, and so your process is stuck waiting for a read/write.

But it *is* a process hung in D state after you sent it a kill.  It's safe to 
assume, at least, that something is screwed up somewhere.  More information 
is always a good thing.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
