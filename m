Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWEIT5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWEIT5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEIT5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:57:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750732AbWEIT5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:57:07 -0400
Date: Tue, 9 May 2006 12:59:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, masouds@masoud.ir, jeff@garzik.org,
       gregkh@suse.de
Subject: Re: [PATCH] VIA quirk fixup, additional PCI IDs
Message-Id: <20060509125916.03c96efe.akpm@osdl.org>
In-Reply-To: <20060509191455.GA27503@taniwha.stupidest.org>
References: <20060430162820.GA18666@masoud.ir>
	<20060509191455.GA27503@taniwha.stupidest.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> An earlier commit (75cf7456dd87335f574dcd53c4ae616a2ad71a11) changed
> an overly-zealous PCI quirk to only poke those VIA devices that need
> it.  However, some PCI devices were not included in what I hope is now
> the full list.
> 
> This should I hope correct this.
> 
> Thanks to Masoud Sharbiani <masouds@masoud.ir> for pointing this out
> and testing the fix.

This looks like a 2.6.17-worthy fix, but it's not clear.  Help.  What
happens if 2.6.17 doesn't have this??

> 
> Signed-of-By: Chris Wedgwood <cw@f00f.org>

Wanna buy an "f"?
