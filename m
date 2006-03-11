Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWCKHri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWCKHri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCKHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:47:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752016AbWCKHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:47:37 -0500
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060310234155.685456cd.akpm@osdl.org>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	 <20060310145605.08bf2a67.akpm@osdl.org>
	 <1142061816.3055.6.camel@laptopd505.fenrus.org>
	 <20060310234155.685456cd.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 08:47:34 +0100
Message-Id: <1142063254.3055.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > but yeah by this time we should just bite the bullet and rename the
> > variable rather than move it about
> 
> That wouldn't help - we'll still break existing scripts.

why? (I mean the KERN_ to FS_ rename in the kernel, that's not exported
to userland anywhere)


