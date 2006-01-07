Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752533AbWAGOt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbWAGOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbWAGOtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:49:55 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57223 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1752533AbWAGOtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:49:55 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: State of the Union: Wireless
Date: Sat, 7 Jan 2006 16:49:35 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060106042218.GA18974@havoc.gtf.org> <1136547084.4037.41.camel@localhost>
In-Reply-To: <1136547084.4037.41.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071649.35321.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 13:31, Johannes Berg wrote:
> On Fri, 2006-01-06 at 12:00 +0100, Michael Buesch wrote:
> 
> > * "master" interface as real device node
> > * Virtual interfaces (net_devices)
> 
> I didn't want to spam the netdev wiki with this (yet) so I collected
> some more structured things outside. Anyone feel free to edit:
> http://softmac.sipsolutions.net/802.11

I am confused.

There is
http://softmac.sipsolutions.net/softmac-snapshot.tar.bz2
at http://softmac.sipsolutions.net/SoftMAC,
page also says "Projects using this layer: * Broadcom 43xx driver"

but Broadcom driver page at ftp://ftp.berlios.de/pub/bcm43xx/snapshots/softmac/
has ftp://ftp.berlios.de/pub/bcm43xx/snapshots/softmac/ieee80211softmac-20060107.tar.bz2
which is not the same. For example, ieee80211softmac.h file exists in both
tarballs but is not identical.

Suppose one wants to use softmac in a project. What tarball contains
the bleeding edge of softmac?

> I'll move that content to the netdev wiki if anyone else thinks it would
> be a good way forward to start with requirements, API issues and
> similar.
> 
> Until we get there, we'll fix up softmac to make it usable for most
> people in basic station mode without any kind of virtual devices, which
> will need some slight changes to the current ieee80211.
--
vda
