Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318126AbSFTGSr>; Thu, 20 Jun 2002 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318127AbSFTGSq>; Thu, 20 Jun 2002 02:18:46 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:28367 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318126AbSFTGSq>;
	Thu, 20 Jun 2002 02:18:46 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15633.29638.375426.808878@napali.hpl.hp.com>
Date: Wed, 19 Jun 2002 23:18:46 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: Re: [PATCH] dup_task_struct can be static
In-Reply-To: <20020620121813.4d1e075f.sfr@canb.auug.org.au>
References: <20020620121813.4d1e075f.sfr@canb.auug.org.au>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 20 Jun 2002 12:18:13 +1000, Stephen Rothwell <sfr@canb.auug.org.au> said:

  Stephen> Hi Linus,
  Stephen> [There may be lots of these depending on how bored I get :-)]

  Stephen> dup_task_struct is defined and used only in kernel/fork.c.

  Stephen> [This is not quite true, as arch/ia64/kernel/process.c also
  Stephen> defines a global dup_task_struct function, but I don't know
  Stephen> how it could ever be called.]

It does---once you apply a small patch by David Howells which hasn't
made it into Linus' tree yet.

	--david
