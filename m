Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbQLHQYe>; Fri, 8 Dec 2000 11:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLHQYY>; Fri, 8 Dec 2000 11:24:24 -0500
Received: from hermes.mixx.net ([212.84.196.2]:5124 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129545AbQLHQYO>;
	Fri, 8 Dec 2000 11:24:14 -0500
From: Daniel Phillips <phillips@innominate.de>
To: caperry@edolnx.net
Subject: Re: Kernel Development Documentation?
Date: Fri, 8 Dec 2000 16:17:01 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>
In-Reply-To: <E144O3Q-0003vP-00@the-village.bc.nu>
In-Reply-To: <E144O3Q-0003vP-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <00120816515701.00491@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2000, Alan Cox wrote:
> > Is there a project underway that documents how things like the VM, the Memory
> > Manger, what a a specific driver needs to do, what it needs to return, how it is
> > called, what do all those files in arch/whatever do?  Are there bits and pieces

Of course we are not really talking Linux api here - these are internal
interfaces.  The Linux syscalls themselves are reasonably
well-documented.  The internal interfaces... weeelllll...

  http://lxr.linux.no

I know exactly how it feels when first getting into the internal kernel
interfaces - for me that was barely a year ago.  I wanted at that time
to try and fix all the documentation problems as I went, but it quickly
turned into a choice between doing useful development and doing useful
documentation.  Guess which one I chose.  I sincerely hope that others
will make the opposite choice, and the linux hacking world will be a
better place.

> For the kernel stuff there is a project to put documentation about functions
> and what they do inline into the kernel. Its slow progress. Trying to do 
> anything formal and structured isnt going to be productive until the 
> documentation is much much more complete
> 
> For syscalls Andries Brouwer maintains a man page collection (and writes many
> of them). He takes submissions.

   http://www.win.tue.nl/math/dw/personalpages/aeb/linux/

Wow, that's useful.  Also check out:

  http://kernelnewbies.org/links/

with many high quality links to kernel documentation around the web.

Tigran Aivazian has been preparing 'Linux Kernel Internals' which is
*highly recommended* and 100% free.  Why don't you get together with
him, and Gary Lawrence Murphy (see his monthy kernel wiki nag)?

Personally, I try to do the right thing and submit at least one piece
of documentation per month to somebody's documenation project but...
it's not always so easy to free up the required hour or two.  This
month my feeble attempt consisted of nagging Ben LaHaise to submit a
particularly lucid email he sent me as a code comment.

Maybe next month will be better.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
