Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUKEWsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUKEWsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKEWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:48:25 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:2833 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261237AbUKEWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:48:23 -0500
Date: Fri, 5 Nov 2004 23:54:38 +0100
To: Chris Wedgwood <cw@f00f.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] major devfs shrink based on tmpfs and lookup traps
Message-ID: <20041105225438.GA14054@hh.idb.hist.no>
References: <200411061021.iA6ALa403415@freya.yggdrasil.com> <20041105211349.GA17340@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105211349.GA17340@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:13:49PM -0800, Chris Wedgwood wrote:
> On Sat, Nov 06, 2004 at 02:21:36AM -0800, Adam J. Richter wrote:
> 
> > This patch is a replacement implementation of devfs.  This patch
> > combined the tmpfs "lookup traps" patch that is required for certain
> > devfs functionality are a net deletion of more than 1800 lines of
> > code[1].  The code that actually remains in fs/devfs has a
> > .text+.data size of under 3kB.
> 
> wow, that's pretty neat.... but isn't devfs going to be killed off
> sooner or later anyhow?
> 
Devfs was dying from lack of maintenance.  So sufficiently active maintenance
may bring it back.  The devfs idea is good . . .

Helge Hafting
