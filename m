Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWAKOD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWAKOD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWAKOD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:03:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:58808 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751637AbWAKOD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:03:58 -0500
Date: Wed, 11 Jan 2006 19:33:38 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060111140338.GF4990@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <200601111212.40989.ak@suse.de> <20060111134230.GE4990@in.ibm.com> <200601111450.07996.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601111450.07996.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 02:50:07PM +0100, Andi Kleen wrote:
> On Wednesday 11 January 2006 14:42, Vivek Goyal wrote:
> 
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
> I don't think that's Stephen's problem.

You are right. This patch is for a entirely different problem. I posted the
patch in the context of this thread because on the surface problem symtoms 
are same.

This patch is required to boot SMP kernel from non-default physical
locations as in case of kdump.

Can you please include this patch.

Thanks
Vivek
