Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTJIJNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 05:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJIJNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 05:13:45 -0400
Received: from mail.skjellin.no ([80.239.42.67]:7627 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261941AbTJIJNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 05:13:44 -0400
Subject: Re: Software RAID5 with 2.6.0-test
From: Andre Tomt <andre@tomt.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1x1xtmg57y.fsf@users.sourceforge.net>
References: <yw1xoewrfizk.fsf@users.sourceforge.net>
	 <1065655452.13572.50.camel@torrey.et.myrio.com>
	 <yw1xad8bfg6q.fsf@users.sourceforge.net> <1065660704.848.10.camel@slurv>
	 <yw1x1xtmg57y.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1065690658.10389.19.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 11:10:59 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 10:55, Måns Rullgård wrote:
> > Was this a 4 port or 2 port HPT controller? Keep in mind, two disks on
> > the same IDE channel severely degrades performance, *especially* with
> > RAID.
> 
> It's a four port SATA controller.  I'd never even think about placing
> two disks on the same cable.

You can't either, considering it is SATA :-)

However, I wouln't count on superior performance from software based
RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
are for.

Out of couriosity, how well is it performing in lets say.. a RAID10 or
RAID1 setup?

-- 
Mvh,
André Tomt
andre@tomt.net

