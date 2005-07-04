Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVGDMBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVGDMBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGDMBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:01:32 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:42390 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261370AbVGDMBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:01:30 -0400
Date: Mon, 4 Jul 2005 07:01:05 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@suse.de>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704120105.GB27617@vino.hallyn.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com> <20050704065902.GO11093@tpkurt.garloff.de> <20050704074449.GA12963@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704074449.GA12963@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@suse.de):
> On Mon, Jul 04, 2005 at 08:59:02AM +0200, Kurt Garloff wrote:
> 
> > > The topic of replacing dummy (with capability) was discussed there
> > > last week, in the context of stacker, but a common solution for both
> > > cases would be needed.
> > 
> > Both cases?
> 
> CONFIG_SECURITY_STACKER and !CONFIG_SECURITY_STACKER ;-)
> 
> http://mail.wirex.com/pipermail/linux-security-module/2005-June/6200.html
> 
> I was assuming (bad of me I know) that Serge's patch would nail both cases
> with one stone.

Yes, sorry, I never got around to the replace-dummy-with-capability
patch.  There wasn't a single cry when Chris asked for anyone who'd
care about dummy being removed, so I do plan on switching that.

thanks,
-serge
