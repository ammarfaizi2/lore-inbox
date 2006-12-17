Return-Path: <linux-kernel-owner+w=401wt.eu-S1751977AbWLQVdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWLQVdF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 16:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWLQVdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 16:33:05 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:2101 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbWLQVdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 16:33:04 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules
Date: Sun, 17 Dec 2006 13:32:56 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEPFAGAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 17 Dec 2006 14:35:27 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 17 Dec 2006 14:35:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would argue that this is _particularly_ pertinent with regards to
> Linux.  For example, if you look at many of our atomics or locking
> operations a good number of them (depending on architecture and
> version) are inline assembly that are directly output into the code
> which uses them.  As a result any binary module which uses those
> functions from the Linux headers is fairly directly a derivative work
> of the GPL headers because it contains machine code translated
> literally from GPLed assembly code found therein.  There are also a
> fair number of large perhaps-wrongly inline functions of which the
> use of any one would be likely to make the resulting binary
> "derivative".

That's not protectable expression under United States law. See Lexmark v.
Static Controls and the analogous case of the TLP (ignore the DMCA stuff in
that case, that's not relevant). If you want to make that kind of content
protectable, you have to get it out of the header files.

You cannot protect, by copyright, every reasonably practical way of
performing a function. Only a patent can do that. If taking something is
reasonably necessary to express a particular idea (and a Linux module for
the ATI X850 card is an idea), then that something cannot be protected by
copyright when it is used to express that idea. (Even if it would clearly be
protectably expression in another context.)

The premise of copyright is that there are millions of equally-good ways to
express the same idea or perform the same function, and you creatively pick
one, and that choice is protected. But if I'm developing a Linux module for
a particular network card, choosing to use the Linux kernel header files is
the only practical choice to perform that particular function. So their
content is not protectable when used in that context. (If you make another
way to do it, then the content becomes protectable in that context again.)

IANAL.

DS


