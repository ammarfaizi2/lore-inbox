Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWBAFVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWBAFVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWBAFVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:21:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:38159 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030365AbWBAFVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:21:12 -0500
Date: Wed, 1 Feb 2006 06:20:06 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: patch to make 2.4.32 work on i486 again
Message-ID: <20060201052006.GB7142@w.ods.org>
References: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 31, 2006 at 11:29:05PM +0100, Jacek Lipkowski wrote:
> Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
> because "Kernel compiled for Pentium+, requires TSC feature!" (printed
> from check_config() include/asm-i386/bugs.h). To reproduce, select 486 in
> the kernel configuration and grep CONFIG_X86_TSC .config
> 
> Seems strange that no one noticed this, am i the only one still using 486
> boxes? :)

perhaps :-)
It's been more than one year since I last booted mine. However, I believe
I came through this bug by accident while compiling a kernel of a VIA Eden
CPU, then I realized it should be compiled as i586 and forgot about the
bug.

> Jacek
> 
> Simple patch against vanilla 2.4.32:

Thanks. I've queued it for the next hotfix.
Marcelo, I've put it in -upstream if you want.

Regards,
Willy

