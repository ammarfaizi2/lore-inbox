Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbVLGTKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbVLGTKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVLGTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:10:11 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:52364 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751774AbVLGTKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:10:09 -0500
Date: Wed, 7 Dec 2005 20:10:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olivier MATZ <zer0@droids-corp.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
Message-ID: <20051207191030.GA7585@mars.ravnborg.org>
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de> <43971BD5.6040601@droids-corp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43971BD5.6040601@droids-corp.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:28:53PM +0100, Olivier MATZ wrote:
> 
> But in my opinion, as we use CONFIG_HERTZ in param.h, we should keep the
> include of config.h.

If you look at the commandline passed to gcc you will notice -include
include/linux/autoconf.h which tell gcc to pull in autoconf.h.
So it is no longer required to include config.h.

	Sam
