Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUHKSQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUHKSQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUHKSQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:16:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:20888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268154AbUHKSQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:16:13 -0400
Date: Wed, 11 Aug 2004 11:16:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: davidm@hpl.hp.com
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040811111609.H1924@build.pdx.osdl.net>
References: <20040810131217.Q1924@build.pdx.osdl.net> <Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com> <16665.56613.143598.768389@napali.hpl.hp.com> <20040811082510.D1924@build.pdx.osdl.net> <16666.24955.224034.291755@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16666.24955.224034.291755@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Aug 11, 2004 at 11:12:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Mosberger (davidm@napali.hpl.hp.com) wrote:
> The macro I had in mind works only for static (compile-time)
> predictions, I'm afraid.

Ah, shoot.  Well, I don't like the penalty from the unlikely() approach,
so we should keep it as-is unless there's another clever solution lurking.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
