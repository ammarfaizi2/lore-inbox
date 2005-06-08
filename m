Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVFHV7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVFHV7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVFHV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:59:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:35536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262087AbVFHV7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:59:33 -0400
Date: Wed, 8 Jun 2005 14:59:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: Chris Wright <chrisw@osdl.org>, Manfred Georg <mgeorg@arl.wustl.edu>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities not inherited
Message-ID: <20050608215904.GE13152@shell0.pdx.osdl.net>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu> <20050608204430.GC9153@shell0.pdx.osdl.net> <1118265642.969.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118265642.969.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg (alexn@telia.com) wrote:
> btw since the last discussion was about not changing the existing
> interface and thus exposing security flaws, what about introducing
> another prctrl that says maybe PRCTRL_ACROSS_EXECVE?

It's not ideal (as you mention, mess upon mess), but maybe it is the
sanest way to go forward.

> Any new user-space applications must understand the implications of
> using it so it's safe in that aspect. Yes?

At least less-likely to surprise ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
