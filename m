Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBPDvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBPDvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBPDvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:51:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932239AbWBPDvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:51:17 -0500
Date: Wed, 15 Feb 2006 19:51:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick length
In-Reply-To: <17395.62667.675949.112899@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0602151950460.916@g5.osdl.org>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
 <20060215173545.43a7412d.akpm@osdl.org> <17395.56186.238204.312647@cargo.ozlabs.ibm.com>
 <20060215180848.4556e501.akpm@osdl.org> <17395.59762.126398.423546@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0602151926590.916@g5.osdl.org> <17395.62667.675949.112899@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Paul Mackerras wrote:
> 
> ... you've forgotten that now I've had to type "time_adjust_step"
> twice. :P

Damn, you're right.

> Anyway, I don't mind changing it, if you think it's worth
> pulling that little bit of code out into its own function.

Sounds sane. Less duplication, and clearer code. Go wild.

		Linus
