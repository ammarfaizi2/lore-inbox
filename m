Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUFDRcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUFDRcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUFDR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:28:53 -0400
Received: from palrel13.hp.com ([156.153.255.238]:45477 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265896AbUFDR1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:27:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.45303.401479.753001@napali.hpl.hp.com>
Date: Fri, 4 Jun 2004 10:27:19 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, luto@myrealbox.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
In-Reply-To: <20040604164032.GA2331@infradead.org>
References: <20040603230834.GF868@wotan.suse.de>
	<20040604092552.GA11034@elte.hu>
	<200406040826.15427.luto@myrealbox.com>
	<Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
	<20040604154142.GF16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
	<20040604155138.GG16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
	<20040604181304.325000cb.ak@suse.de>
	<20040604163753.GN16897@devserv.devel.redhat.com>
	<20040604164032.GA2331@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 4 Jun 2004 17:40:32 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> On Fri, Jun 04, 2004 at 06:37:54PM +0200, Arjan van de
  Christoph> Ven wrote:
  >> Fedora makes the heap non executable too; it only broke X which
  >> has it's own shared library loader (which btw had all the right
  >> mprotects in place, just ifdef'd for freebsd, ia64 and a few
  >> other architectures that default to non-executable heap, so we
  >> just added x86(-64) to that)

  Christoph> Maybe you should just call mprotect always to be safe? :)
  Christoph> OTOH I guess the world would end if a X release had less
  Christoph> ifdefs than the previous one..

No kidding!

	--david
