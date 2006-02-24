Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWBXNAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWBXNAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWBXNAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:00:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:58275 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750943AbWBXNAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:00:47 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Date: Fri, 24 Feb 2006 14:00:41 +0100
User-Agent: KMail/1.9.1
Cc: dilinger@debian.org, linux-kernel@vger.kernel.org
References: <1140777679.5073.17.camel@localhost.localdomain> <200602241147.03041.ak@suse.de> <20060224045044.07fc5921.akpm@osdl.org>
In-Reply-To: <20060224045044.07fc5921.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602241400.42432.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 13:50, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > I can offer you a deal though: if you fix VGA scrollback to have
> >  at least 1000 lines by default we can change the oops formatting too.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/vgacon-add-support-for-soft-scrollback.patch

Once that is in and works we can consider changing the oopses.

> Problem is, scrollback doesn't work after panic().  I don't know why..

Someone claimed it was related to the panic keyboard blinking.  Never verified 
though. But without it working we still can't change the oops.

-Andi
 
