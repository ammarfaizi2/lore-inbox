Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269758AbTGKBxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbTGKBxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:53:46 -0400
Received: from palrel11.hp.com ([156.153.255.246]:26509 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S269758AbTGKBxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:53:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16142.7192.736814.766448@napali.hpl.hp.com>
Date: Thu, 10 Jul 2003 19:08:24 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: per_cpu fixes 
In-Reply-To: <20030711020147.96A282C113@lists.samba.org>
References: <16141.43130.657025.952793@napali.hpl.hp.com>
	<20030711020147.96A282C113@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 11 Jul 2003 12:01:08 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> This catches one common case for ia64 to use the magic pinned
  Rusty> area, and also allows x86 to use its incl/decl instructions,
  Rusty> which both networking stats and module refcounts have wanted
  Rusty> for a while.

Looks fine to me.

	--david
