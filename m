Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbSJRBbU>; Thu, 17 Oct 2002 21:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbSJRBbU>; Thu, 17 Oct 2002 21:31:20 -0400
Received: from mail.powweb.com ([63.251.213.34]:31696 "EHLO mail.powweb.com")
	by vger.kernel.org with ESMTP id <S262707AbSJRBbT> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 21:31:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <markgross@thegnar.org>
Organization: thegnar
To: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Date: Thu, 17 Oct 2002 18:35:21 -0700
User-Agent: KMail/1.4.3
Cc: Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>,
       NPT library mailing list <phil-list@redhat.com>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <m33cr4pn56.fsf@averell.firstfloor.org>
In-Reply-To: <m33cr4pn56.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210171835.21647.markgross@thegnar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 06:10 pm, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
>
>
> [...]
>
> This is not directly related to mt coredumps, but for anybody hacking the
> core dumper:
>
> it would be cool if error code/trapno were included in the coredump in some
> elf note. It has always annoyed me that these were lost and they can
> be very useful to diagnose crashes that are caused by kernel problems.
>
> -Andi

What more do you want?  You have all the registers, the mm and at least a 
dissasembly of the code, you even have the signr in the NT_PRSTATUS section.

--mgross


