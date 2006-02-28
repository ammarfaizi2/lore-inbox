Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWB1WjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWB1WjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWB1WjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:39:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19098 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932586AbWB1WjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:39:16 -0500
Date: Tue, 28 Feb 2006 23:38:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: col-pepper@piments.com
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: o_sync in vfat driver
Message-ID: <20060228223855.GC5831@elf.ucw.cz>
References: <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <op.s5nm6rm5j68xd1@mail.piments.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 28-02-06 00:21:53, col-pepper@piments.com wrote:
> On Mon, 27 Feb 2006 22:32:07 +0100, linux-os (Dick Johnson)  
> <linux-os@analogic.com> wrote:
> 
> > Flash does not get zeroed to be written! It gets erased, which sets all
> > the bits to '1', i.e., all bytes to 0xff.
> 
> Thanks for the correction, but that does not change the discussion.
> 
> > Further, the designers of
> > flash disks are not stupid as you assume. The direct access occurs
> > to static RAM (read/write stuff).
> 
> I'm not assuming anything . Some hardware has been killed by this issue.
> http://lkml.org/lkml/2005/5/13/144

I have seen flash disk dead in 5 minutes, even without o-sync. Those
devices are often crap. (I copied tar file to flash by cat foo.tar >
/dev/sda. That was apparently enough to kill that flash. Label "Yahoo"
should have warned me).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
