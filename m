Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUKDAQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUKDAQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbUKDANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:13:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64397 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261971AbUKDAM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:12:29 -0500
Date: Thu, 4 Nov 2004 01:04:06 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tom Rini <trini@kernel.crashing.org>
cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
In-Reply-To: <20041103183415.GH381@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.61.0411040044570.877@scrub.home>
References: <20041102232001.370174C0BC@zion.localdomain>
 <Pine.LNX.4.61.0411031747020.17266@scrub.home> <20041103174856.GG381@smtp.west.cox.net>
 <Pine.LNX.4.61.0411031909460.877@scrub.home> <20041103183415.GH381@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Nov 2004, Tom Rini wrote:

> How about how easy it is to create a totally bogus config for any arch?

I'm open to suggestions, but this patch doesn't solve the problem.

> > You can misconfigure a kernel 
> > in native compiles as well, this patch solves the wrong problem. 
> 
> I disagree.  This solves the "why did the kernel decide to look at
> /boot/config when it really should have known better" problem.

In a lot of other cases it does make sense. The kconfig core shouldn't 
behave differently if we are cross compiling.

bye, Roman
