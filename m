Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUF2LB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUF2LB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUF2LB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:01:59 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:43226 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264260AbUF2LB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:01:57 -0400
Date: Tue, 29 Jun 2004 13:01:53 +0200
From: David Weinehall <tao@debian.org>
To: ca_tex-kernel@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL question
Message-ID: <20040629110153.GF14311@khan.acc.umu.se>
Mail-Followup-To: ca_tex-kernel@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20040628221349.55700.qmail@web11505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628221349.55700.qmail@web11505.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 03:13:49PM -0700, ca_tex-kernel@yahoo.com wrote:
> Hopefully this is not going to start a huge thread war on open source
> philosophy and such, but the company I work for has some proprietary
> code built as a 2.4 linux kernel module for a product they sell.  They
> are concerned about releasing the source code.  I noticed that what
> this code does and how it does it seems pretty clean (at least
> GPL-wise), but it does modify sys_call_table to add a system call
> which is then used to call the module from userland.  Can they avoid
> releasing this code or is this crossing into a gray area?  I used to
> think I more or less understood the basics of the GPL, but after
> talking to their lawyers I am totally confused.  Thanks.

Philosophical issues aside (I suppose everyone on this list prefers to
see drivers free) the main point that decides if a driver has to be
released with source is whether it can be considered a derived work or
not.  to the best of my knowledge, the exception for binary modules in
the kernel was mainly to provide for drivers ported from other operating
systems, rather than to allow for competlely new drivers to be kept
closed source.  If the driver can be claimed to be developed without
having access to other things than header-files, it can probably be
considered non-derived, but a drivers that has to modify the
sys_call_table is dangerously close to being a derived work (if not
already past the border-line...)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
