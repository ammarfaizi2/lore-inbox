Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUH0T1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUH0T1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUH0T1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:27:16 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3224 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267360AbUH0TS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:18:59 -0400
Subject: pwc+pwcx is not illegal
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: pmarques@grupopie.com, greg@kroah.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093634283.431.6370.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Aug 2004 15:18:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques writes:

> About the legal aspects of all this, they have been
> discussed extensively in the past. It is not about
> "hey this is just a simple hook", it is all about
> the derived work concept. This driver does absolutely
> nothing outside the kernel. It's only purpose is to
> attach itself to the kernel and to provide the images
> from the camera to userspace using the kernel ABI's.
> So you can not say it is not a derived work at all.

(note: the following is not legal advice)

I think you'll find that this is not supported by
the copyright law, at least in the United States and
in any sane country.

Richard Stallman and The SCO Group might like your
interpretation, at least when it serves them, but
that doesn't make it the law.

What protectable elements of the kernel have been
included within the driver? I don't see any.
Like we say to SCO, where are the lines of code?
Remember, nobody is distributing a kernel with
this driver linked in. Merely loading the driver
is obviously fair use of the kernel.

(BTW, something which is required for operation
is not protectable. See the Sega v. Accolade case.
Thus, mere usage of header files won't do. You
couldn't even use the C header files on any UNIX
system if that were the case. Let's not be silly.)

Is it "non-literal copying" that concerns you?
Heh. OK. Name the jurisdiction you like, and
describe the copyright infringement test accepted
by the courts in that jurisdiction.

For example, the US 10th Circuit uses the "abstraction,
filtration, comparison" test. The US 9th Circuit uses
the "Analytic Dissection" test. There are others.
I don't know of any such test under which the
closed-source part of the driver could be considered
to be a derived work of the Linux kernel. I can hardly
imagine one that would make the driver derived without
also making Linux derived from UNIX!

So anyway... where are the lines of code?


