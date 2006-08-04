Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161519AbWHDVv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519AbWHDVv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWHDVv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:51:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53462 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161505AbWHDVv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:51:57 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [RFC] irqbalance: Mark in-kernel irqbalance as obsolete, set  to N by default
To: Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       jesse.brandeburg@intel.com, john.ronciak@intel.com,
       netdev@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 04 Aug 2006 23:48:16 +0200
References: <6EJUl-4br-13@gated-at.bofh.it> <6FXVd-1Gl-11@gated-at.bofh.it> <6G9jL-1Yg-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G97X3-0000pH-IY@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> wrote:

> to some degree the in kernel balancer cannot really make the level of
> decisions that a userspace balancer can make, at least not without making all
> kernel developers vomit ;)

If you make the drivers set a flag if they know their interrupts should remain
mostly on one CPU, you can avoid the bad cases, and the rest you could gain
from using more clever algorithms should be(*) usurally less than what parsing
/proc/interrupts costs.

*) as in: I guess
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
