Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVARUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVARUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVARUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:15:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58840 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261397AbVARUPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:15:23 -0500
Date: Tue, 18 Jan 2005 21:15:19 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andreas Gruenbacher <agruen@suse.de>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by default
In-Reply-To: <20050118192608.423265000.suse.de>
Message-ID: <Pine.LNX.4.61.0501182106340.6118@scrub.home>
References: <20050118184123.729034000.suse.de> <20050118192608.423265000.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Jan 2005, Andreas Gruenbacher wrote:

> A user ran into the following problem: They grab a SuSE kernel-source
> package that is more recent than their running kernel. The tree under
> /usr/src/linux is unconfigured by default; there is no .config. User
> does a ``make menuconfig'', which gets its default values from
> /boot/config-$(uname -r). User tries to build the kernel, which doesn't
> work.

NAK. This isn't normally supposed to happen and it shouldn't be as bad 
anymore as it used to be. Removing these path doesn't magically create a 
working kernel.

bye, Roman
