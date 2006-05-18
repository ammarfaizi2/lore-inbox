Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWERMZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWERMZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWERMZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:25:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19394 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751357AbWERMZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:25:55 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 2/3] reliable stack trace support (x86-64)
Date: Thu, 18 May 2006 14:25:51 +0200
User-Agent: KMail/1.9.1
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4469FC22.76E4.0078.0@novell.com> <200605181220.46037.ak@suse.de> <446C7E61.76E4.0078.0@novell.com>
In-Reply-To: <446C7E61.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181425.51442.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Maybe I'm dense but I still don't get - frame has a pt_regs so why 
> >isn't the caller allowed to know about that fact?
> 
> Because the fact that there is a regs fields and the PC is accessible through it is architecture specific, yet the
> caller (kernel/unwind.c) ought to be architecture independent.

I doubt we have any architecture where the instruction pointer is not in pt_regs,
but ok.

-Andi

