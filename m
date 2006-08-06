Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWHFGBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWHFGBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 02:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWHFGBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 02:01:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53707 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932686AbWHFGBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 02:01:21 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder
Date: Sun, 6 Aug 2006 08:01:10 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Jones <davej@redhat.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200608060105_MC3-1-C73A-EF22@compuserve.com>
In-Reply-To: <200608060105_MC3-1-C73A-EF22@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608060801.10475.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 07:00, Chuck Ebbert wrote:
> In-Reply-To: <200608060430.06935.ak@suse.de>
> 
> On Sun, 6 Aug 2006 04:30:06 +0200, Andi Kleen wrote:
> > 
> > > +extern void stext(void); /* real start of kernel text */
> > 
> > Can't you use _stext[] from asm/sections.h?
> 
> OK.

Applied thanks. I did a similar x86-64 change.

-Andi
