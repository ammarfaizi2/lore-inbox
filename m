Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTD3XDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTD3XDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:03:42 -0400
Received: from ns.suse.de ([213.95.15.193]:47890 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262524AbTD3XDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:03:42 -0400
Date: Thu, 1 May 2003 01:14:54 +0200
From: Andi Kleen <ak@suse.de>
To: Rafael Santos <rafael@thinkfreak.com.br>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: software reset
Message-ID: <20030430231454.GA16195@Wotan.suse.de>
References: <p73vfwx2uw8.fsf@oldwotan.suse.de> <1UVQRFALHIE82ZYICTO43SQVTC751.3eb05572@rafaelnote.ns1.lhost.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1UVQRFALHIE82ZYICTO43SQVTC751.3eb05572@rafaelnote.ns1.lhost.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 08:00:02PM -0300, Rafael Santos wrote:
> 	#define MODULE 1
> 	#define __KERNEL__ 1
> 
> 	What are those for? What do they do?

Required for the kernel include files. __KERNEL__ says it's a kernel
compilation and MODULE says it's a module.

Normally they are declared in the kernel makefiles, but for custom
modules with a makefile I tend to write them as defines for convenience.

In 2.5 you'll also need KBUILD_MODNAME

-Andi
