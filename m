Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbTFCMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTFCMWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:22:16 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:56278 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264775AbTFCMWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:22:15 -0400
Date: Tue, 3 Jun 2003 07:36:36 -0400
From: Ben Collins <bcollins@debian.org>
To: Jocelyn Mayer <jma@netgem.com>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
Message-ID: <20030603113636.GX10102@phunnypharm.org>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com> <20030602163443.2bd531fb.georgn@somanetworks.com> <1054588832.4967.77.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054588832.4967.77.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 11:20:32PM +0200, Jocelyn Mayer wrote:
> On Mon, 2003-06-02 at 22:34, Georg Nikodym wrote:
> > On 02 Jun 2003 21:36:22 +0200
> > Jocelyn Mayer <jma@netgem.com> wrote:
> > 
> > > ... at least for PPC targets.
> > 
> > As a datapoint, works fine for me with my x86 laptop:
> 
> Hi,
> 
> OK, so it should be an endianness related problem...
> I didn't test this on a PC because I need (want ?)
> to always use the same kernel on my Mac & my PC
> so I can test my patches always in the same conditions.
> It gives me a start point to investigate...

No, it's a rescan-scsi-bus.sh issue. Get the script, and execute it.
Hotplug for 2.4.x scsi is a fantasy. Just so happens it used to work,
but that "work" used to cause oopses.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
