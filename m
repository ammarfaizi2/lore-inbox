Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTDWV6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbTDWV6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:58:08 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:57357 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264258AbTDWV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:58:07 -0400
Date: Wed, 23 Apr 2003 23:10:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "B. Joshua Rosen" <bjrosen@polybus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is anyone manitaing make xconfig?
Message-ID: <20030423231013.A10133@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"B. Joshua Rosen" <bjrosen@polybus.com>,
	linux-kernel@vger.kernel.org
References: <1051135494.4872.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051135494.4872.26.camel@localhost.localdomain>; from bjrosen@polybus.com on Wed, Apr 23, 2003 at 06:04:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 06:04:55PM -0400, B. Joshua Rosen wrote:
> Make xconfig has been broken for some time now, is anyone still
> maintaining it? I contacted the listed maintainer, Michael Elizabeth
> Chastain, who said that she is no longer maintaining it. 
> 
> Make xconfig is pretty important, it's hard to imagine that it's going
> to be allowed to rot.
> 
> Here is the compile error for 2.4.21-rc1,
> 
> /home/tmp/linux-2.4.20> make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/home/tmp/linux-2.4.20/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate

the config.in is broken, not xconfig..

