Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGLTKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGLTKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGLTKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:10:40 -0400
Received: from palrel12.hp.com ([156.153.255.237]:16082 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261184AbUGLTKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:10:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16626.57892.533203.683465@napali.hpl.hp.com>
Date: Mon, 12 Jul 2004 12:10:28 -0700
To: Ingo Molnar <mingo@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jakub Jelinek <jakub@redhat.com>,
       davidm@hpl.hp.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407121428270.22224@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	<20040711123803.GD21264@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	<20040712182431.GB28281@infradead.org>
	<Pine.LNX.4.58.0407121428270.22224@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 Jul 2004 14:29:16 -0400 (EDT), Ingo Molnar <mingo@redhat.com> said:

  >> Well, it's not.  We probably want each new port start to have the ia64
  >> behaviour, so it should be abstracted out nicer.

  Ingo> is it an issue? Each new port will have PT_GNU_STACK, unless they base
  Ingo> themselves on old compilers.

PT_GNU_STACK is pure bloat on new architectures (and ia64).

	--david
