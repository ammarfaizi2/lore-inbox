Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVBOEu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVBOEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 23:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVBOEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 23:50:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:3016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbVBOEuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 23:50:52 -0500
Date: Mon, 14 Feb 2005 20:50:40 -0800
From: Chris Wright <chrisw@osdl.org>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 0/5: LSM hooks rework
Message-ID: <20050215045040.GK27645@shell0.pdx.osdl.net>
References: <20050213210515.GH27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213210515.GH27893@tpkurt.garloff.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kurt Garloff (garloff@suse.de) wrote:
> this goes back to a discussion in August last year:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0408.1/0623.html

Thanks for follow up Kurt.  I'm travelling at the moment so bear with me
if my response time is slow.  In short, I don't mind switching over to
default capabilities and the consolidation of inline functions.  The
last optimization is pessimistic for case where module is in use, so let's
hold on that one at least as we work out any minor nits with the first
three patches.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
