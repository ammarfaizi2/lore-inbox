Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290513AbSARCYI>; Thu, 17 Jan 2002 21:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290514AbSARCX7>; Thu, 17 Jan 2002 21:23:59 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:13329 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S290513AbSARCXu>; Thu, 17 Jan 2002 21:23:50 -0500
Date: Fri, 18 Jan 2002 13:23:59 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: <mingo@elte.hu>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Problems with O(1) scheduler on non-x86 arch's
Message-Id: <20020118132359.3cbca3f3.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0201171046480.2000-100000@localhost.localdomain>
In-Reply-To: <200201170229.g0H2TnY04563@localhost.localdomain>
	<Pine.LNX.4.33.0201171046480.2000-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002 10:50:58 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> in the long term i think the correct approach would be to always store the
> logical CPU number in p->cpu.

The hotplug CPU patch gets rid of the whole concept of "logical CPU number".
This is even cleaner, and avoids these mistakes which bite us all the time.

	http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
