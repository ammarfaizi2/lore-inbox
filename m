Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTKWHN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTKWHN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 02:13:27 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:61379
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263325AbTKWHN0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 02:13:26 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: The plug and play menu is ISA only?
Date: Sun, 23 Nov 2003 01:04:01 -0600
User-Agent: KMail/1.5
References: <200311212041.22604.rob@landley.net> <yw1xhe0xcba0.fsf@kth.se>
In-Reply-To: <yw1xhe0xcba0.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311230104.02083.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 November 2003 21:49, Måns Rullgård wrote:
> Rob Landley <rob@landley.net> writes:
> > Is the "plug and play" menu just ISA plug and play only?  (It has nothing
> > to do with hotplug or anything else, right?  PCI devices are "plug and
> > play", but that's an actual part of the PCI spec.  USB is hotplug and
> > play, etc.)
> >
> > Or is this also used for on-motherboard devices in modern systems?  (Is
> > it ever likely to be needed on a laptop made in the last five years, for
> > eample?)
>
> The only time you ever need to select ISA plug and play, is if you
> have an old PnP ISA card.  You'd know if you did.  Modern systems
> don't even have ISA slots.

Shouldn't it be removed the "devices" menu and stuck under bus options->isa 
then?  (Yeah, not a critical fix.  But is this sort of thing a 2.6.1 
candidate or a 2.7 candidate?)

Rob
