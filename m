Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272994AbTHKTBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTHKS7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:59:38 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:17537 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S272824AbTHKS6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:58:19 -0400
Subject: Re: Kconfig -- kill "if you want to read about modules, see" crap?
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@redhat.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, James Simmons <jsimmons@infradead.org>
In-Reply-To: <20030811182451.GA3151@redhat.com>
References: <200308111400.h7BE01NL000208@81-2-122-30.bradfords.org.uk>
	 <1060625643.1736.10.camel@spc9.esa.lanl.gov>
	 <20030811182451.GA3151@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060628268.1736.16.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Aug 2003 12:57:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 12:24, Dave Jones wrote:
> On Mon, Aug 11, 2003 at 12:14:04PM -0600, Steven Cole wrote:
> 
>  > Here is a little patch to implement this for
>  > drivers/input/keyboard/Kconfig for a start.  The patch also fixes some
>  > module names which were wrong (cut and paste errors).
> 
> We could go one stage further, and add to Kconfig..
> 
> 	MODULE_NAME=atkbd
> 
> for each option, which would also allow us to only show that info
> of CONFIG_MODULES=y, as well as eliminating the redundancy.
> 
> 		Dave

We will need to accommodate this situation:

[steven@spc5 2.5-linux]$ find . -name Makefile | xargs grep IP6_NF_MATCH_AHESP
./net/ipv6/netfilter/Makefile:obj-$(CONFIG_IP6_NF_MATCH_AHESP) += ip6t_esp.o ip6t_ah.o

Steven





