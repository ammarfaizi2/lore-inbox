Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVIJWI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVIJWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVIJWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:08:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932178AbVIJWI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:08:27 -0400
Date: Sat, 10 Sep 2005 15:04:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050910150446.116dd261.akpm@osdl.org>
In-Reply-To: <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
	<20050910014543.1be53260.akpm@osdl.org>
	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> On Sep 10, 2005, at 04:45:43, Andrew Morton wrote:
> > This patch seems to have a rather low value-to-noise ratio.  Why
> > on earth do we want to do this?
> 
> When I started trying to split out the userspace<=>kernelspace ABI  
> headers, I
> found a number of things (such as __ASSEMBLY__) that would not operate
> properly in userspace.

Oh, OK.

What's the status of this userspace ABI project?  Is it a thing we want to
do?  How far along is it?  Have we worked out how it is to be done?  I
haven't been paying much attention to the discussion (self-defense reflex
;))


