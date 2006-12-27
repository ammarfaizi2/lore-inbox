Return-Path: <linux-kernel-owner+w=401wt.eu-S932976AbWL0Pxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbWL0Pxa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbWL0Pxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:53:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36992 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbWL0Px3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:53:29 -0500
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
	2.6.x kernels
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: knobi@knobisoft.de
Cc: Gleb Natapov <glebn@voltaire.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061227154158.54796.qmail@web32608.mail.mud.yahoo.com>
References: <20061227154158.54796.qmail@web32608.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 16:53:26 +0100
Message-Id: <1167234806.3281.3966.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
>  this is a real interesting question. Ganglia is coming [originally]
> from the HPC side of computing. At least in the past HT as implemented
> on XEONs did help a lot. Running two CPU+memory-bandwith intensive
> processes on the same physical CPU would at best result in a 50/50
> performance split. So, knowing how many "real" CPUs are in a system is
> interesting to us.

but this 50/50 split is most likely because of either a cache or a
bandwidth bottleneck, at which point "HT" is the wrong measure.

(also if you go to things like SUN's Niagara CPU then it's even more
clear that SMT isn't the right measure for performance capability)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

