Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbRFXJCn>; Sun, 24 Jun 2001 05:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263863AbRFXJCX>; Sun, 24 Jun 2001 05:02:23 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:19425 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263814AbRFXJCU>; Sun, 24 Jun 2001 05:02:20 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: allan.d@bigpond.com (Allan Duncan), linux-kernel@vger.kernel.org
Subject: Re: Shared memory quantity not being reflected by /proc/meminfo
In-Reply-To: <200106240249.f5O2nIF07215@saturn.cs.uml.edu>
Organisation: SAP LinuxLab
In-Reply-To: <200106240249.f5O2nIF07215@saturn.cs.uml.edu>
Message-ID: <m3n16yjmkl.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 24 Jun 2001 10:44:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

On Sat, 23 Jun 2001, Albert D. Cahalan wrote:
> You misunderstood what 2.2.xx kernels were reporting.
> The "shared" memory in /proc/meminfo refers to something
> completely unrelated to SysV shared memory. This is no
> longer calculated because the computation was too costly.

But the load of misinterpretations and the missing value led me to
export the number of shmem pages in later -ac kernels exactly in this
field.

I know it is a change of semantics and because of this both Alan and
me asked for comments if this change is appreciated. I am still
waiting for responses though.

Greetings
		Christoph


