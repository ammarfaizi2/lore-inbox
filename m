Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUA0RjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUA0RjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:39:12 -0500
Received: from palrel13.hp.com ([156.153.255.238]:64135 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263891AbUA0RjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:39:07 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16406.41527.446833.703928@napali.hpl.hp.com>
Date: Tue, 27 Jan 2004 09:39:03 -0800
To: Jes Sorensen <jes@wildopensource.com>
Cc: davidm@hpl.hp.com, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for ia64
In-Reply-To: <yq0y8rtreug.fsf@wildopensource.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
	<16405.41953.344071.456754@napali.hpl.hp.com>
	<yq0y8rtreug.fsf@wildopensource.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 27 Jan 2004 03:11:03 -0500, Jes Sorensen <jes@wildopensource.com> said:

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:
  Jes> David,

  Jes> I am just nitpicking here, but wouldn't it be better to stick
  Jes> to the convention of all upper case defines for the #ifdef
  Jes> check?

Yeah, it is nitpicking! ;-)

  Jes> Maybe use something like?  #define ARCH_EXTABLE_COMPARE_ENTRIES
  Jes> ia64_extable_compare_entries

I'd rather have ARCH_HAS_EXTABLE_COMPARE_ENTRIES or something like
that, in that case.

	--david
