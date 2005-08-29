Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVH2Ixl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVH2Ixl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVH2Ixl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:53:41 -0400
Received: from ns.firmix.at ([62.141.48.66]:52944 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750778AbVH2Ixl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:53:41 -0400
Subject: Re: syscall: sys_promote
From: Bernd Petrovitsch <bernd@firmix.at>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       dhommel@gmail.com
In-Reply-To: <4312C45D.4050801@fc-cn.com>
References: <20050826092537.GA3416@localhost.localdomain>
	 <20050826124738.GD28640@harddisk-recovery.com> <4312873F.8060006@fc-cn.com>
	 <1125302028.4882.10.camel@tara.firmix.at> <4312C45D.4050801@fc-cn.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 29 Aug 2005 10:53:28 +0200
Message-Id: <1125305608.4882.28.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 16:16 +0800, Coywolf Qi Hunt wrote:
> Bernd Petrovitsch wrote:
[...]
> >(almost) every tool may become a security problem.
> >If you fear a bug in sudo, then write a minimal setuid wrapper for
> >yourself which checks for the user it started and exec's a binary (with
> >the full path name specified).
> >And even then - dependent on other details of the setup - you have the
> >gap of security problems (or misuse) because of holes in the security.
> 
> But if we make sure a tool doesn't introduce any new secrutiy problem, 
> that's good enough.

ACK. That's basically the idea behind "write 15 lines of C code and be
absolutely sure that there is no problem in there".

[...]
> >What does the user do if the process terminates (for whatever reason)
> >and must be restarted by the user (manually or auutomatically)?
> 
> If we worry that, we'd make a persistent OS instead.
> 
> >Basically I can see no need for "one time in history" actions. A daemon
> >can terminate and must be restarted (it may even be a software bug that
> >causes this and this doesn't change anything that the daemon's admin
> >must restart it *now*). The machine may reboot for whatever reason .... 
> 
> The US space shuttle certainly can auto pilot, so it doesn't need a 
> control panel.
> And If anything fails, NASA  just launch another ship?

I didn't realize that you are working on (one-time) Space Shuttle
software.
I assumed average servers, services and environment ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

