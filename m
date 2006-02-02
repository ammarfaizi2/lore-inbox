Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWBBXVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWBBXVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBBXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:21:33 -0500
Received: from hera.kernel.org ([140.211.167.34]:6109 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932453AbWBBXVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:21:32 -0500
Date: Thu, 2 Feb 2006 15:21:21 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: patch to make 2.4.32 work on i486 again
Message-ID: <20060202212121.GA27974@dmt.cnet>
References: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl> <20060201052006.GB7142@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201052006.GB7142@w.ods.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:20:06AM +0100, Willy Tarreau wrote:
> Hi,
> 
> On Tue, Jan 31, 2006 at 11:29:05PM +0100, Jacek Lipkowski wrote:
> > Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
> > because "Kernel compiled for Pentium+, requires TSC feature!" (printed
> > from check_config() include/asm-i386/bugs.h). To reproduce, select 486 in
> > the kernel configuration and grep CONFIG_X86_TSC .config
> > 
> > Seems strange that no one noticed this, am i the only one still using 486
> > boxes? :)
> 
> perhaps :-)
> It's been more than one year since I last booted mine. However, I believe
> I came through this bug by accident while compiling a kernel of a VIA Eden
> CPU, then I realized it should be compiled as i586 and forgot about the
> bug.
> 
> > Jacek
> > 
> > Simple patch against vanilla 2.4.32:
> 
> Thanks. I've queued it for the next hotfix.
> Marcelo, I've put it in -upstream if you want.

Patch is correct indeed - thanks Willy.
