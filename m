Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264242AbUESPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbUESPhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUESPfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:35:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264242AbUESPeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:34:04 -0400
Date: Wed, 19 May 2004 08:59:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Carson Gaspar <carson@taltos.org>
Cc: Marco Fais <marco.fais@abbeynet.it>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040519115950.GE12419@logos.cnet>
References: <406D3E8F.20902@abbeynet.it> <20040504010714.GA8028@logos.cnet> <765880000.1083774300@taltos.ny.ficc.gs.com> <20040505183558.GB1350@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505183558.GB1350@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 03:35:58PM -0300, Marcelo Tosatti wrote:
> On Wed, May 05, 2004 at 12:25:00PM -0400, Carson Gaspar wrote:
> > --On Monday, May 03, 2004 22:07:14 -0300 Marcelo Tosatti 
> > <marcelo.tosatti@cyclades.com> wrote:
> > 
> > >On Fri, Apr 02, 2004 at 12:21:03PM +0200, Marco Fais wrote:
> > >>Hi!
> > >>
> > >>
> > >>[1.] Kernel panic while using distcc
> > >>
> > >>[2.] I have 5-6 development linux systems that we use without problem
> > >>under a normal development workload. Trying distcc for speeding up
> > >>compilation, we have a fully reproducible kernel panic in a very short
> > >>time (seconds after compilation start). The kernel panic happens *only*
> > >>when the systems are "remotely controlled" (the distcc daemon is
> > >>receiving source files from remote systems, compile and send back
> > >>compiled objects). When compiling with distcc the local system doesn't
> > >>show any kernel panic, while the same system used as a "remote compiler
> > >>system" dies very quickly.
> > >>
> > >>[3.] Keywords: distcc BUG page_alloc.c
> > >Marco, Carson,

Hi Carson, 

So did Andrea's fix work for you? :) 
