Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265342AbSJaVBg>; Thu, 31 Oct 2002 16:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbSJaVBg>; Thu, 31 Oct 2002 16:01:36 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:3833 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265342AbSJaVBe>; Thu, 31 Oct 2002 16:01:34 -0500
Date: Thu, 31 Oct 2002 16:08:00 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Herrmann <AHERRMAN@de.ibm.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net,
       lkcd-devel-admin@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021031160800.M18072@redhat.com>
References: <OFEC1A12FD.509981CC-ONC1256C63.00746AAA@de.ibm.com> <Pine.LNX.4.44.0210311239430.2334-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210311239430.2334-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 31, 2002 at 12:40:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 12:40:28PM -0800, Linus Torvalds wrote:
> And imnsho, debugging the kernel on a source level is the way to do it.
> 
> Which is why it's not going to be me who merges it.
> 
> Read my emails.

That is one of the reasons that crash dumps are useful.  Quite a few 
problems that customers hit are not easy to reproduce, but when they 
provide a dump file that can be loaded into gdb with the original 
kernel debugging info and the backtrace command issued and various 
bits of internal structures examined, usually a good hypothesis can 
be made for the cause.  Feed that back into a code audit and you end 
up fixing problems that are decidedly challenging.

		-ben
-- 
"Do you seek knowledge in time travel?"
