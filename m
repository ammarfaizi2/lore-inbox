Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030659AbWI0TTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030659AbWI0TTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbWI0TTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:19:44 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:5822 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030659AbWI0TTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:19:43 -0400
Date: Wed, 27 Sep 2006 21:19:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Randy Dunlap <dunlap@xenotime.net>, arnd Bergmann <arnd@arndb.de>,
       luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Message-ID: <20060927191922.GA2909@wohnheim.fh-wedel.de>
References: <6.1.1.1.0.20060927132022.01ed0450@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6.1.1.1.0.20060927132022.01ed0450@ptg1.spd.analog.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 September 2006 13:47:16 -0400, Robin Getz wrote:
> 
> Does anyone have a script that identifies white space problems?

If you use vim:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
