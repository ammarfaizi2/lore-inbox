Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUEDBGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUEDBGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUEDBGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:06:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264175AbUEDBGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:06:32 -0400
Date: Mon, 3 May 2004 22:07:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: linux-kernel@vger.kernel.org, Carson Gaspar <carson@taltos.org>
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040504010714.GA8028@logos.cnet>
References: <406D3E8F.20902@abbeynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406D3E8F.20902@abbeynet.it>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 12:21:03PM +0200, Marco Fais wrote:
> Hi!
> 
> 
> [1.] Kernel panic while using distcc
> 
> [2.] I have 5-6 development linux systems that we use without problem
> under a normal development workload. Trying distcc for speeding up
> compilation, we have a fully reproducible kernel panic in a very short
> time (seconds after compilation start). The kernel panic happens *only*
> when the systems are "remotely controlled" (the distcc daemon is
> receiving source files from remote systems, compile and send back
> compiled objects). When compiling with distcc the local system doesn't
> show any kernel panic, while the same system used as a "remote compiler
> system" dies very quickly.
> 
> [3.] Keywords: distcc BUG page_alloc.c

Marco, Carson,

Can you please try to reproduce this distcc generated oops using 2.4.27-pre2?
 
Thanks!

