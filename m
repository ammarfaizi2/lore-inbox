Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265324AbTLHDwB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTLHDwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:52:00 -0500
Received: from mail.webmaster.com ([216.152.64.131]:5847 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265324AbTLHDv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:51:58 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jeremy Maitin-Shepard" <jbms@attbi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Additional clauses to GPL in network drivers
Date: Sun, 7 Dec 2003 19:51:54 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEMBIIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <87r7zg0zrg.fsf@jay.local.invalid>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > 	It occurs to me that it might not be a bad idea to have a
> > short blurb that
> > could be included in individual files that clarifies that the
> > file is part
> > of a GPL'd distribution but that's clear that it doesn't impose any
> > additional restrictions. Here's a stab at such a notice just
> > off the top of
> > my head:

> [snip]
>
> I don't understand the desire for a notice that is clearly redundant.
> Due to the nature of the GPL (version 1 or 2), licensing an entire work
> under it is exactly equivalent to licensing all of the component parts
> individually under it.

	It is definitely redundant. The idea is that if a portion of the
distribution ever winds up somewhere, the terms are still clear. For
example, one often finds modified header files or implementation files
available that don't contain a copy of the GPL or, for that matter, any
indication that the files included are covered by the GPL.

	For this reason, I think it makes sense for files to carry some indication
that they are covered by the GPL. Look, for example, at
ftp://ftp.scyld.com/pub/network/tulip.c

	If this file is to be made available for download by itself, it must
contain some notice that it is covered by the GPL. The current notice,
however, is broken:

	This software may be used and distributed according to the terms of
	the GNU General Public License (GPL), incorporated herein by reference.
	Drivers based on or derived from this code fall under the GPL and must
	retain the authorship, copyright and license notice.  This file is not
	a complete program and may only be used when the entire operating
	system is licensed under the GPL.

	So I'm suggesting a fixed notice that could replace the broken notice.

	DS


