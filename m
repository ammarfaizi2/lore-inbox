Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTAKLoN>; Sat, 11 Jan 2003 06:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbTAKLoN>; Sat, 11 Jan 2003 06:44:13 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:33415 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267191AbTAKLoL>; Sat, 11 Jan 2003 06:44:11 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: jgarzik@pobox.com, mantel@suse.de, Natalie.Protasevich@UNISYS.com,
       linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
References: <20030109224013$6e5e@gated-at.bofh.it>
	<20030111110011$3252@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: 11 Jan 2003 12:51:52 +0100
In-Reply-To: <20030111110011$3252@gated-at.bofh.it>
Message-ID: <m3n0m729bb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

<some other obviously wrong already refuted FUD snipped>

> 
> They also violate the GPL by including non-GPL compliant code (openssl and
> the unisys es7000 support) in their tree, so..

When the ES7000 Code was merged we asked Unisys about this and they
agreed to drop the nasty conflicting clauses (in fact it was just 
a mistake on their part - the code was always intended to be GPLed) 
The bogus comment may have leaked out in one or two revisions with 
the daily kernel snapshot.

openssl is only compiled as a module in released kernels, so it is similar to
the PPP BSD compression module.

I would recommend people check their facts and ask first before publicly 
accusing someone of violating the GPL.

-Andi

In the current version the copyright note in es7000.[ch] reads:

 * Copyright (c) 2002 Unisys Corporation.  All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it would be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * Further, this software is distributed without any warranty that it is
 * free of the rightful claim of any third person regarding infringement
 * or the like.  Any license provided herein, whether implied or
 * otherwise, applies only to this software file.  Patent licenses, if
 * any, provided herein do not apply to combinations of this program with
 * other software, or any other product whatsoever.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write the Free Software Foundation, Inc., 59
 * Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * Contact information: Unisys Corporation, Township Line & Union Meeting 
 * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
 *
 * http://www.unisys.com
