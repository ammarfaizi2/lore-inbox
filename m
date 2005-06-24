Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVFXUir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVFXUir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVFXUio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:38:44 -0400
Received: from palrel11.hp.com ([156.153.255.246]:44481 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263220AbVFXUhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:37:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17084.28403.603616.786034@napali.hpl.hp.com>
Date: Fri, 24 Jun 2005 13:37:07 -0700
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: davidm@hpl.hp.com, akpm@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux IA64 <linux-ia64@vger.kernel.org>
Subject: Re: [patch][ia64]Refuse kprobe on ivt code- take 2
In-Reply-To: <20050624122333.A5213@unix-os.sc.intel.com>
References: <20050623172832.B26121@unix-os.sc.intel.com>
	<17083.25625.991516.736507@napali.hpl.hp.com>
	<20050624114545.A4826@unix-os.sc.intel.com>
	<17084.23214.237084.224128@napali.hpl.hp.com>
	<20050624122333.A5213@unix-os.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 24 Jun 2005 12:23:33 -0700, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> said:

  Anil> On Fri, Jun 24, 2005 at 12:10:38PM -0700, David Mosberger wrote:
  >> >>>>> On Fri, 24 Jun 2005 11:45:46 -0700, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> said:
  >> Surely you meant to use the declaration from sections.h instead?

  Anil> Take 1: This patch is based on review comments from David Mosberger,
  Anil> now checking based on .text.ivt
  Anil> Take 2: now including sections.h :-)

Looks fine to me.

Thanks,

	--david
