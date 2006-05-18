Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWERMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWERMDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWERMDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:03:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:50612
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751002AbWERMDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:03:51 -0400
Message-Id: <446C7F0A.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 18 May 2006 14:04:58 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH 1/3] reliable stack trace support
References: <4469FC07.76E4.0078.0@novell.com> <20060518111625.GA2026@elf.ucw.cz>
In-Reply-To: <20060518111625.GA2026@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/*
>> + * Copyright (C) 2002-2006 Novell, Inc.
>> + *	Jan Beulich <jbeulich@novell.com>
>> + *
>> + * A simple API for unwinding kernel stacks.  This is used for
>> + * debugging and error reporting purposes.  The kernel doesn't need
>> + * full-blown stack unwinding with all the bells and whistles, so there
>> + * is not much point in implementing the full Dwarf2 unwind API.
>
>Missing GPL?

I took include/asm-ia64/unwind.h's header as a template - is there anything wrong with that?

Jan
