Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbULPXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbULPXow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbULPXnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:43:13 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:6692 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262202AbULPXlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:41:32 -0500
Date: Fri, 17 Dec 2004 00:41:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christian Bj??levik <nafallo@magicalforest.se>, rusty@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>,
       Debian-Kernel <debian-kernel@lists.debian.org>
Subject: Re: PROBLEM: Cross-compiling fails (patch included)
Message-ID: <20041216234153.GA15485@mars.ravnborg.org>
Mail-Followup-To: Christian Bj??levik <nafallo@magicalforest.se>,
	rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>,
	Debian-Kernel <debian-kernel@lists.debian.org>
References: <41C1D4A5.3080503@magicalforest.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C1D4A5.3080503@magicalforest.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 07:32:05PM +0100, Christian Bj??levik wrote:
>  Hi there!
> 
> When using kernel-package (Debian specific kernel-management) to 
> cross-compile a kernel in a i386-chroot on my x86_64 laptop 
> modules_install fails when trying to depmod things. Since we should not 
> depmod those things if the arch being built isn't the same as 'uname -m' 
> I wrote a patch for the Makefile to test those conditions.

Similar versions has been posted before.
But the right fix is to fix module-init-tools - therefore they have not
been applied.

Rusty - any progress in this?

	Sam
