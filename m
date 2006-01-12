Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWALANR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWALANR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWALANR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:13:17 -0500
Received: from ns2.suse.de ([195.135.220.15]:49823 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932655AbWALANQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:13:16 -0500
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Thu, 12 Jan 2006 01:12:51 +0100
User-Agent: KMail/1.8.2
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <20060111134230.GE4990@in.ibm.com> <20060111160520.02c0ec73@dxpl.pdx.osdl.net>
In-Reply-To: <20060111160520.02c0ec73@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120112.51762.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 01:05, Stephen Hemminger wrote:

> > 
> > While testing this I ran into another problem with same symtoms. If 
> > I compile my kernel for physical location greater than or equal to 
> > 16MB then only BP boots and applicatoin processors don't come up. I had
> > noticed this problem in i386 and posted a patch. Here is the similar  patch 
> > for x86_64.
> > 
> > Though the symtoms are same but this does not seem to be related to the
> > problem which Stephen is facing as he seems to be compiling the kernel
> > for 1MB location only.
> 
> Aha... Yes, this fixes the problem.

Ok I will submit it then. 

-Andi
