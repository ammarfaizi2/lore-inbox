Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWFVR3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWFVR3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWFVR3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:29:48 -0400
Received: from [198.99.130.12] ([198.99.130.12]:61060 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751404AbWFVR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:29:47 -0400
Date: Thu, 22 Jun 2006 13:29:41 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UML compilation fails on JB_*
Message-ID: <20060622172941.GA5337@ccure.user-mode-linux.org>
References: <Pine.LNX.4.61.0606221823040.21525@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606221823040.21525@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 06:26:31PM +0200, Jan Engelhardt wrote:
> arch/um/os-Linux/sys-i386/registers.c:139: error: ???JB_BP??? undeclared (first 
> use in this function)
> 
> I have seen this before (while trying to cross-compile a sparc64-glibc from 
> i586); the reason is that I do not have any header files containing 
> definitions for JB_PC. What additional packages do I need?

You need http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17/patches/jmpbuf

				Jeff
