Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTFYP6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTFYP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:56:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264629AbTFYP4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:56:10 -0400
Date: Wed, 25 Jun 2003 09:10:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: kde@myrealbox.com, linux-kernel@vger.kernel.org
Subject: Re: Weird modem behaviour in 2.5.73-mm1
Message-Id: <20030625091013.573f2e7b.shemminger@osdl.org>
In-Reply-To: <200306250418.h5P4IWdA001565@turing-police.cc.vt.edu>
References: <200306242102.49356.kde@myrealbox.com>
	<200306250327.h5P3RwH8001577@turing-police.cc.vt.edu>
	<200306250418.h5P4IWdA001565@turing-police.cc.vt.edu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 00:18:31 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Tue, 24 Jun 2003 23:27:57 EDT, Valdis.Kletnieks@vt.edu said:
> 
> Reverting this one cset makes the modem work for me under 2.5.73-mm1.
> With it in place, pppd hung up before even finishing the option
> negotiations.  With it reverted, it's staying up.  There's apparently
> something subtly wrong with the part that hits ppp_generic.c, although
> I admit not understanding enough to see exactly what.

How far along did pppd get before it hung up?  Was the ppp0 netdevice still
around (ifconfig -a)?  I'll try a dedicated serial line and see if I can reproduce
it.
