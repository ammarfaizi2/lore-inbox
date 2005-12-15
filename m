Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVLOWE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVLOWE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLOWE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:04:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751127AbVLOWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:04:58 -0500
Date: Thu, 15 Dec 2005 14:06:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com, jgarzik@pobox.com
Subject: Re: Geode LX HW RNG Support
Message-Id: <20051215140622.53c37335.akpm@osdl.org>
In-Reply-To: <20051215214432.GB14013@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
	<20051215211423.GF11054@cosmic.amd.com>
	<20051215133917.3f0a5171.akpm@osdl.org>
	<20051215214432.GB14013@cosmic.amd.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> wrote:
>
> > Should all the Geode additions to hw_random.c be inside __i386__, like VIA?
> 
> I thought that a early version did that and somebody took exception to 
> it, but I can't find any e-mails to that effect right now.  Obviously, 
> the defines are only useful when you have a Geode CPU (and thus a x86_32), 
> so if nobody complains, I think that would be fine.

Fair enough.  Please send an update sometime.

We might as well do s/__i386__/X86_32/ throughout that file - bit pointless
but it's a little bit more idiomatic.
