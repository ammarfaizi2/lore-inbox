Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVLGVcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVLGVcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbVLGVcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:32:16 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:30240 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751778AbVLGVcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:32:16 -0500
Date: Wed, 7 Dec 2005 22:32:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olivier MATZ <zer0@droids-corp.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
Message-ID: <20051207213245.GA7575@mars.ravnborg.org>
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de> <43971BD5.6040601@droids-corp.org> <20051207191030.GA7585@mars.ravnborg.org> <4397418E.3070400@droids-corp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4397418E.3070400@droids-corp.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:09:50PM +0100, Olivier MATZ wrote:
> Hi Sam,
> 
> > If you look at the commandline passed to gcc you will notice -include
> > include/linux/autoconf.h which tell gcc to pull in autoconf.h.
> > So it is no longer required to include config.h.
> 
> I'm not sure. On my 2.6.14.3, this is a compilation line 
Ok, I was speaking on the 2.6.15-rc kernels. I was added when 2.6.15
opened up and will first appear in a 'relased' kernel as of 2.6.15.

> Moreover, if I try to compile a C file which only define a variable and
> assign it to a CONFIG_XXX, it doesn't work. Did I do something wrong ?
I do not get what you tried and what did not work.

	Sam
