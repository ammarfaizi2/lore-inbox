Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUD0Xl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUD0Xl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbUD0Xl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:41:57 -0400
Received: from [66.35.79.110] ([66.35.79.110]:26254 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264430AbUD0Xlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:41:50 -0400
Date: Tue, 27 Apr 2004 16:41:36 -0700
From: Tim Hockin <thockin@hockin.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: Michael Poole <mdpoole@troilus.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427234136.GA17801@hockin.org>
References: <20040427230545.GA15747@hockin.org> <Pine.LNX.4.44.0404280114580.15111-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404280114580.15111-100000@hubble.stokkie.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 01:30:58AM +0200, Robert M. Stockmann wrote:
> > What the hell do these two paragraphs have to do with each other?
> 
> C99 coding style, more specific the use of unnamed and anonymous structures
> and unions, allows the kernel programmer to interface, read glue, binary only
> driver modules to interface with any linux kernel source tree.

What the hell are you going on about?  Unnamed structures are a
syntactical construct and have ZILCH to do with runtime.

> The needed header files, which need to be read by the gcc compiler, contain
> unnamed and annonymizes structures and unions. In the worst case scenario,
> only the name of used variables are given and no info about variable type or
> size are inside these headers files. gcc-2.95.3 fails to succesfully link these

Opaque types have been available FOREVER.
