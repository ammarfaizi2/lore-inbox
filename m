Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJWBxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJWBxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:53:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261380AbTJWBxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:53:02 -0400
Date: Thu, 23 Oct 2003 02:53:01 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Matt Zimmerman <mdz@debian.org>
Subject: Re: Linux 2.4.23-pre8
Message-ID: <20031023015301.GN7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 09:24:17PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -pre8... It contains a quite big amount of ACPI fixes,
> networking changes, network driver changes, few IDE fixes, SPARC merge, SH
> merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.
> 
> People seeing boot IDE related crashes on Alpha with previous kernels
> please try this.

	BTW, another thing that might be worth rechecking is the pile of bugs
related to ownership of ksymoops files.  In particular, bugs.debian.org/171947
might have been caused by the bug fixed in 2.4.23-pre8 (UID/GID leaking into
modprobe).  Matt, do you still see that crap appearing in /var/log/ksymoops
with that kernel?
