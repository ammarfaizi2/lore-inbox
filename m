Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVCCQXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVCCQXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVCCQXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:23:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:65444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262019AbVCCQV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:21:26 -0500
Date: Thu, 3 Mar 2005 08:21:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-ID: <20050303162114.GP28536@shell0.pdx.osdl.net>
References: <20050301012741.1d791cd2.akpm@osdl.org> <20050301214916.GJ28536@shell0.pdx.osdl.net> <200503030804.j2384WBY016301@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503030804.j2384WBY016301@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Dike (jdike@addtoit.com) wrote:
> chrisw@osdl.org said:
> > I just did a more complete grep of the symbols that can get config'd
> > away (including CONFIG_AUDIT as well), and I think there's a few more
> > missing pieces.  Sorry about that.  Jeff, Ralf, Martin, these look ok?
> 
> For UML, this is fine as far as it goes, but you're adding register references
> to arch-independent code, so this is needed as well:

Thanks, I'll push that with rest of audit changes.  Mind adding a
Signed-off-by?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
