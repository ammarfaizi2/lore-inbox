Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVAIPBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVAIPBl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 10:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVAIPBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 10:01:41 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:16298 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261449AbVAIPBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 10:01:39 -0500
Date: Sun, 9 Jan 2005 16:02:08 +0100
From: DervishD <lkml@dervishd.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Message-ID: <20050109150208.GA543@DervishD>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl> <41E1170D.6090405@feix.cz> <20050109115554.GA9183@irc.pl> <20050109122557.GA221@DervishD> <1105273893.4173.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1105273893.4173.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Arjan :)

 * Arjan van de Ven <arjan@infradead.org> dixit:
> >     But the set of sanitized kernel headers, if you build your own
> > software and you're not using a distro, is only available for 2.6.x
> > kernels, not for 2.4.x kernels. 
> The headers RH ships work for both...

    Did not know...

> > What should be done for 2.4 kernels?
> > I currently use a set of headers from the 2.4 kernel I used to build
> > my libc, not the headers from the current kernel I'm running, but I
> > would like to know anyway.
> .... and you can use 2.6 headers to build a glibc that works excellent
> for 2.4 kernels too. The kernel API/ABI *does not change on this level*
> between kernel versions. Things may get added, but they do not change.

    That's perfect then :))) No problem about the headers then. When
I recompile my glibc I'll pick the latest libc-kernel-headers
available. Thanks a lot for the information, Arjan :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
