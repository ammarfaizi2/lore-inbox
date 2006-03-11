Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWCKHXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWCKHXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCKHXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:23:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750812AbWCKHXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:23:38 -0500
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060310145605.08bf2a67.akpm@osdl.org>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	 <20060310145605.08bf2a67.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 08:23:36 +0100
Message-Id: <1142061816.3055.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 14:56 -0800, Andrew Morton wrote:
> Kurt Garloff <garloff@suse.de> wrote:
> >
> > Diffing in sysctl.c is tricky, using more context is recommended.
> > suid_dumpable ended up in fs/ instead of kernel/ and the reason
> > is likely a patch with too little context.
> 
> It's been in kernel/ since 2.6.13.  What will break if we move it?
> 
> This is security-related.  If we move it we risk unsecuring people's
> machines...

only a very little bit since the default value is "secure", the option
is to make it "insecure"...
but yeah by this time we should just bite the bullet and rename the
variable rather than move it about


