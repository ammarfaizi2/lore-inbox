Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266698AbUGQEh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUGQEh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUGQEh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 00:37:26 -0400
Received: from palrel12.hp.com ([156.153.255.237]:55956 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266670AbUGQEhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 00:37:23 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16632.44288.370612.885408@napali.hpl.hp.com>
Date: Fri, 16 Jul 2004 21:37:20 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: davidm@hpl.hp.com, Mark Haverkamp <markh@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407161837260.20824@ppc970.osdl.org>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	<20040711123803.GD21264@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
	<16626.62318.880165.774044@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407122358570.13111@devserv.devel.redhat.com>
	<1089734729.1356.79.camel@markh1.pdx.osdl.net>
	<16632.28018.130890.290832@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407161837260.20824@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 16 Jul 2004 18:39:40 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> said:

  Linus> No. Using "def_flags" was a mistake for the whole VM_EXEC
  Linus> thing. It's not designed for that, and it doesn't work that
  Linus> way. I applied the paper-over fix that gets it
  Linus> almost-working, but I'm waiting for Ingo to rewrite it by
  Linus> just saving the "executable_stack" information at exec time,
  Linus> and not playing with def_flags at all.

I'm very happy to hear that.

Thanks,

	--david
