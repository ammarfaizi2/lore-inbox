Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWHABSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWHABSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWHABSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:18:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49595 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751456AbWHABST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:18:19 -0400
From: Andi Kleen <ak@suse.de>
To: dsaxena@plexity.net
Subject: Re: [PATCH] x86_64 built-in command line
Date: Tue, 1 Aug 2006 03:18:06 +0200
User-Agent: KMail/1.9.3
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060731171442.GI6908@waste.org> <20060801010652.GA17771@plexity.net>
In-Reply-To: <20060801010652.GA17771@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010318.06459.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 03:06, Deepak Saxena wrote:
> On Jul 31 2006, at 12:14, Matt Mackall was caught saying:
> > Allow setting a command line at build time on x86_64. Compiled but not
> > tested.
> 
> Can we just make this into a generic option and put the relevant strcpy
> (strcat) in init/main.c. We've supported a default in-kernel command line
> on ARM for sometime now and I think it would be best to just have a single
> implementation.

One problem is that some architectures (like i386/x86-64) have early 
boot arguments that are processed before init/main

-Andi
