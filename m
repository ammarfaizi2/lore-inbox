Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUGFQPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUGFQPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGFQPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:15:07 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:8588 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264097AbUGFQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:14:56 -0400
Date: Tue, 6 Jul 2004 18:14:51 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
Message-ID: <20040706161451.GA26925@merlin.emma.line.org>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040705231131.GA5958@merlin.emma.line.org> <40EACB64.2010503@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EACB64.2010503@comcast.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2004, John Richard Moser wrote:

> The only thing I've seen kill java like that would be NX things, such as
> the NX patch mentioned in an earlier thread; execshield; or PaX.  I saw
> some talk about possibly enabling NX by default; but I don't see this in
> the -mm6 list, and I have no idea where the bk patch list is.  I
> wouldn't expect either Linus or Andrew to have decided to merge an NX
> patch in at this stage; but it's a possibility.

I've been pointed to the NX feature off-list and investigated, my CPU
(AMD Athlon XP 2500+ Model 10 "Barton") doesn't support the noexec flag,
and dmesg does not contain any output that MX was enabled, and the Java
"Killed" problem persists when the kernel is booted with noexec=off.

It must have entered the tree between v2.6.7 and revision 1.1757 in
Linus' tree.

BTW, how do I tell BitKeeper "pull up to revision..."?  bk pull and bk
undo -aREV is a way, but it's wasteful.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
