Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCXXWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUCXXWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:22:20 -0500
Received: from hera.kernel.org ([63.209.29.2]:20123 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262080AbUCXXWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:22:18 -0500
Date: Wed, 24 Mar 2004 21:22:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040325002257.GA7454@logos.cnet>
References: <20040324205811.GB6572@logos.cnet> <20040324122806.4015d3d6.akpm@osdl.org> <20040324215112.GA6931@logos.cnet> <20040324213648.GA17896@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324213648.GA17896@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 10:36:48PM +0100, Matthias Andree wrote:
> On Wed, 24 Mar 2004, Marcelo Tosatti wrote:
> 
> > This should work. Matthias, please apply and try to reproduce.
> 
> Didn't compile. I have changed that line 119 to bad_page(__FUNCTION__,
> page); instead. If the first argument must be something else, let me
> know. It doesn't immedately make sense with just one caller, but I know
> nothing better right now.

Right. My mistake.

> As I don't know a specific scenario to reproduce the crash, it may take
> longer (possibly weeks) until I can come up with results.

Lets wait and see.

Did you try older 2.4's or 2.6 ? 
