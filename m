Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWAGWNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWAGWNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWAGWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:13:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:686 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030614AbWAGWNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:13:24 -0500
Date: Sat, 7 Jan 2006 17:13:17 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060107221317.GT9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <20060107214208.GR9402@redhat.com> <43C037B8.8080401@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C037B8.8080401@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 04:50:48PM -0500, Brice Goglin wrote:
 > Dave Jones wrote:
 > 
 > > > Should I prevent my initscript from loading agpgart (actually intel_agp)
 > > > at all ? (I guess udev or hotplug is trying to load it here). Is there
 > > > something like agpgart for PCI express ? Or is it useless ?
 > >
 > >it's useless. though the loading of it shouldn't harm anything.
 > >Does it spew warnings during your boot ?
 > >  
 > >
 > No, I don't see any warning/problem.

I'm curious how you noticed this change of behaviour at all then :-)
(The only user visible change is that it no longer prints anything
 about agpgart during boot. Was that what tipped you off?)

		Dave

