Return-Path: <linux-kernel-owner+w=401wt.eu-S932973AbWL0QJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbWL0QJf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWL0QJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:09:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41371 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973AbWL0QJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:09:34 -0500
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
	2.6.x kernels
From: Arjan van de Ven <arjan@infradead.org>
To: knobi@knobisoft.de
Cc: Gleb Natapov <glebn@voltaire.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061227155104.91856.qmail@web32607.mail.mud.yahoo.com>
References: <20061227155104.91856.qmail@web32607.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 17:09:32 +0100
Message-Id: <1167235772.3281.3977.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>  actually I wanted to write that "HT as implemented on XEONs did not
> help a lot for HPC workloads in the past"....


btw this is exactly the problem I am trying to point out: ".. as
implemented in generation XYZ model ABC of processor DEF".
that's going to be really fragile and in fact won't work even for
processors you can buy today (power5 and sparc niagara for example, and
depending on the workload, even on todays 16Mb cache Xeons).

once your program (and many others) have such a check, then the next
step will be pressure on the kernel code to "fake" the old situation
when there is a processor where <vague criteria of the day> no longer
holds. It's basically a road to madness :-(

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

