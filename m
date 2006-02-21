Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWBUVn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWBUVn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBUVn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:43:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932089AbWBUVnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:43:25 -0500
Date: Tue, 21 Feb 2006 13:41:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-Id: <20060221134139.11b8668b.akpm@osdl.org>
In-Reply-To: <200602211318_MC3-1-B8E8-E64E@compuserve.com>
References: <200602211318_MC3-1-B8E8-E64E@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
> 
> On Mon, 20 Feb 2006 at 04:26:15 -0800, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> 
> Could you merge my trivial patches?
> 
> i386-allow-disabling-x86_feature_sep-at-boot.patch
>         I keep having to backport this one because I need it for testing mainline.
> 
> i386-__devinit-should-be-__cpuinit.patch
>         Saves a few K when HOTPLUG && !HOTPLUG_CPU
> 
> i386-fall-back-to-sensible-cpu-model-name.patch
>         Rohit signed off on this one.
> 
> kbuild-add-fverbose-asm-to-i386-makefile.patch
>         Nice to have and does this for all archs, not just i386.
> 

None of these are must-have fixes, are they?   I had them queued for 2.6.17.
