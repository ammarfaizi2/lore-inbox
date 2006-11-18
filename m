Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753872AbWKRWSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbWKRWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbWKRWSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:18:16 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:50053 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753872AbWKRWSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:18:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=d6xOSKX2Q60sjfHoJMz0zAV/4aWaXJfcPEre14YrJ50JpFbSx0ajCL3bniMHu0S+7oS9B/1x8pIBpnD+HAnfE6lpmvB88CCytGlcp9u0wxheQcwjbZjZXvXgLwetJv7hiEjfyzFyoc4Vcagkc/U45OUVML5zcDAKOg8S8Gt+2QA=  ;
X-YMail-OSG: Ewql5coVM1nPCnMvyMC.NORIEVpYZchglqz3xiiDmi4UBvpZEdU7hpyVOM3D6VaUAxXxdiob3A4dJtLoHbOrts4ACEevPL.g72lpYVEVHvjDwp1A8TR7wAUNCyfpPQzl6.XH_g0jZN4du225aQ1v_4b9mwZBs2k2LxA-
From: David Brownell <david-b@pacbell.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Sat, 18 Nov 2006 14:18:09 -0800
User-Agent: KMail/1.7.1
Cc: Anderson Briglia <anderson.briglia@indt.org.br>,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB1FB.1060403@indt.org.br> <200611181117.54242.david-b@pacbell.net> <455F7E2A.60009@drzeus.cx>
In-Reply-To: <455F7E2A.60009@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181418.10675.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 November 2006 1:42 pm, Pierre Ossman wrote:
> David Brownell wrote:
> > I thought the MMC vendors expected to see the actual user-typed
> > password get SHA1-hashed into a value which would take up the whole
> > buffer?  In general that's a good idea, since it promotes use of
> > longer passphrases (more information) over short ones (easy2crack).
> >   
> 
> This sounds like policy though, so it is something user space should
> concern itself with. We should just provide the infrastructure.

The kernel shouldn't hash, right.  But the userspace toos
probably should be doing that ... they're the other part of
the infrastructure. :)

- Dave
