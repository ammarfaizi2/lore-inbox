Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTFRXmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbTFRXmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:42:50 -0400
Received: from palrel13.hp.com ([156.153.255.238]:50612 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265615AbTFRXmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:42:49 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.64573.582305.388014@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 16:56:45 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, roland@redhat.com,
       sam@ravnborg.org
Subject: Re: common name for the kernel DSO
In-Reply-To: <20030618163551.0cd6b867.akpm@digeo.com>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
	<20030618203247.GA14124@mars.ravnborg.org>
	<16112.60671.410179.275282@napali.hpl.hp.com>
	<20030618163551.0cd6b867.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 16:35:51 -0700, Andrew Morton <akpm@digeo.com> said:

  Andrew> David Mosberger <davidm@napali.hpl.hp.com> wrote:
  >>  +++ edited/arch/i386/kernel/Makefile Wed Jun 18 15:47:48 2003 @@
  >> -47,7 +47,7 @@ cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
  >> -Wl,-T,$(filter-out FORCE,$^) -o $@
  >> 
  >> -vsyscall-flags = -shared -s -Wl,-soname=linux-vsyscall.so.1
  >> +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1

  Andrew> What happens if one architecture decides to take this up to
  Andrew> linux-gate.so.2?  If that is even a legit thing to do.

Beats me.  Roland?

	--david
