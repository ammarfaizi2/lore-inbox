Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLHRi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLHRi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 12:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVLHRi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 12:38:57 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:64281 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750760AbVLHRi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 12:38:56 -0500
Date: Thu, 8 Dec 2005 18:39:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olivier MATZ <zer0@droids-corp.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
Message-ID: <20051208173916.GA8103@mars.ravnborg.org>
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de> <43971BD5.6040601@droids-corp.org> <20051207191030.GA7585@mars.ravnborg.org> <4397418E.3070400@droids-corp.org> <20051207213245.GA7575@mars.ravnborg.org> <439819FF.5020704@droids-corp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439819FF.5020704@droids-corp.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 12:33:19PM +0100, Olivier MATZ wrote:
> I have one more question about dependancies : in 2.6.15-rc, if we modify
> the config, do we have to recompile everything ?
No, kbuild will rebuild only what is necessary. That may be a lot,
or it may be only very limited. Depending on what symbol you change.

	Sam
