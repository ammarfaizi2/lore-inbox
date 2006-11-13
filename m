Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755144AbWKMPiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbWKMPiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbWKMPiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:38:19 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55466 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1755144AbWKMPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:38:18 -0500
Date: Mon, 13 Nov 2006 10:37:52 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andi Kleen <ak@suse.de>
cc: Alexander van Heukelum <heukelum@mailshack.com>,
       LKML <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
Subject: Re: [PATCH] make x86_64 boot gdt size exact (like x86).
In-Reply-To: <200611110742.53632.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0611131037050.17168@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
 <200611101501.40007.ak@suse.de> <Pine.LNX.4.58.0611110010330.5626@gandalf.stny.rr.com>
 <200611110742.53632.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Nov 2006, Andi Kleen wrote:

> On Saturday 11 November 2006 06:17, Steven Rostedt wrote:
> >
> > Andi,
> >
> > Here's another patch that is basically a copy from x86's boot/setup.S.
> > It makes the GDT limit the exact size that is needed.  I tested this with
> > the same Xen test that broke the original 0x8000 size, and it booted just
> > fine.
>
> I had already changed the previous patch to be like that
>
> (except for the - 1)
>

Andi,

Do you have the exact patch that you applied somewhere public?  A git repo
or something. I'd like to match what will be going upstream exactly.

Thanks.

-- Steve

