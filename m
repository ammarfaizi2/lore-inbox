Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272417AbRIOQ2S>; Sat, 15 Sep 2001 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272420AbRIOQ2I>; Sat, 15 Sep 2001 12:28:08 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:32269 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S272407AbRIOQ17>; Sat, 15 Sep 2001 12:27:59 -0400
To: Ben Collins <bcollins@debian.org>
Cc: Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] modutils: ieee1394 device_id extraction
In-Reply-To: <m38zfgmohp.fsf@dk20037170.bang-olufsen.dk>
	<20010915121233.U8723@visi.net>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 15 Sep 2001 18:28:13 +0200
In-Reply-To: <20010915121233.U8723@visi.net>
Message-ID: <m34rq4mnaa.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 15-09-2001 18:28:18,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 15-09-2001 18:28:22,
	Serialize complete at 15-09-2001 18:28:22
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> writes:

> On Sat, Sep 15, 2001 at 06:02:10PM +0200, Kristian Hogsberg wrote:
> > 
> > Hi,
> > 
> > I've been adding hotplug support to the ieee1394 subsystem, and the
> > ieee1394 stack in cvs now calls the usermode helper just like usb, pci
> > and the rest of them.  Next step is to extend depmod so it extracts
> > the device id tables from the 1394 device drivers, which is exactly
> > what the patch below does.
> > 
> > Keith, would you apply this to modutils?
> 
> Any ETA on converting the sbp2 driver to the hotplug/nodemgr interfaces?
> I can either sync the current CVS with Linus as-is, or wait till that is
> done, if you think it will be done soon.

I think you should merge it as-is.  The sbp2 driver will still work
with the hotplug system, it just does it's own probing now.  As for
the ETA, I'll be working on it this weekend, so I hope to have
something ready soon.

Kristian

