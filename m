Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWAKV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAKV4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWAKV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:56:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750760AbWAKV4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:56:34 -0500
Date: Wed, 11 Jan 2006 16:56:15 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060111215615.GA11668@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com> <Pine.LNX.4.58.0601112149270.8371@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601112149270.8371@skynet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:50:31PM +0000, Dave Airlie wrote:

 > > That's puzzling. It should still be loadable. All the current agpgart tree
 > > is doing is basically enforcing agp=off if there's no agp card present.
 > > That shouldn't prevent the module from actually loading, or it's symbols being
 > > referenced by other modules.
 > >
 > > Hrmm, it's puzzling that you also are unable to resolve drm_open and drm_release.
 > > That may be a follow-on failure from the first, but it seems unlikely.
 > 
 > Thats' just a cascaded failure, radeon gives out because drm won't load
 > because agpgart won't load... there must be a reason why agpgart doesn't
 > load... perhaps we've some issue when the backend isn't there or
 > something..

It may be that my current experiment is a really bad idea, and if it
causes drm heartburn, I'll drop it.  But if you could take a peek
just incase drm is doing something silly I'd appreciate it.

		Dave

