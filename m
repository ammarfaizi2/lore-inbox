Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVBYSOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVBYSOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVBYSOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:14:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:18122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262771AbVBYSO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:14:28 -0500
Date: Fri, 25 Feb 2005 10:13:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: aq <aquynh@gmail.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-ID: <20050225181333.GG28536@shell0.pdx.osdl.net>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr> <9cde8bff050225085479761ef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff050225085479761ef4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* aq (aquynh@gmail.com) wrote:
> Just try something like this: 
> 
>  +#ifdef CONFIG_FORK_CONNECTOR
>  +
>  +               fork_connector(current->pid, p->pid);
> #endif

It's generally preferred to bury this in header files.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
