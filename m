Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947111AbWKKGnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947111AbWKKGnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 01:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947114AbWKKGnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 01:43:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:40339 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1947111AbWKKGnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 01:43:16 -0500
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] make x86_64 boot gdt size exact (like x86).
Date: Sat, 11 Nov 2006 07:42:53 +0100
User-Agent: KMail/1.9.5
Cc: Alexander van Heukelum <heukelum@mailshack.com>,
       LKML <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <200611101501.40007.ak@suse.de> <Pine.LNX.4.58.0611110010330.5626@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0611110010330.5626@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110742.53632.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2006 06:17, Steven Rostedt wrote:
> 
> Andi,
> 
> Here's another patch that is basically a copy from x86's boot/setup.S.
> It makes the GDT limit the exact size that is needed.  I tested this with
> the same Xen test that broke the original 0x8000 size, and it booted just
> fine.

I had already changed the previous patch to be like that

(except for the - 1)

-Andi
