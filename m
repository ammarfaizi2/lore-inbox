Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbTCLVYz>; Wed, 12 Mar 2003 16:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCLVYz>; Wed, 12 Mar 2003 16:24:55 -0500
Received: from fmr02.intel.com ([192.55.52.25]:32195 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262061AbTCLVYy>; Wed, 12 Mar 2003 16:24:54 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1E8@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: RE: [BK PATCH] 2.4 ACPI update
Date: Wed, 12 Mar 2003 13:35:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christoph Hellwig [mailto:hch@infradead.org] 
> On Wed, Mar 12, 2003 at 11:12:43AM -0800, Grover, Andrew wrote:
> >  arch/i386/kernel/acpitable.c            |  554 ----
> >  arch/i386/kernel/acpitable.h            |  260 --
> 
> No reason to remove this.

The ACPI patch implements CPU-enum-only support in exactly the same way
that 2.5 does, so my thinking was that this code is no longer needed.

If this *has* been the roadblock to 2.4 patch acceptance for the past 16
months, then obviously I would be willing to revert that cset and keep
it, but I do think the patch does keep the functionality provided by
those files - i.e. the ability to get ACPI table parsing for cpu enum
without adding the interpreter to the kernel image.

Regards -- Andy
