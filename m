Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272422AbRIORkm>; Sat, 15 Sep 2001 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272421AbRIORkc>; Sat, 15 Sep 2001 13:40:32 -0400
Received: from ppp25.ts2-2.NewportNews.visi.net ([209.8.198.25]:50422 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S272407AbRIORk1>; Sat, 15 Sep 2001 13:40:27 -0400
Date: Sat, 15 Sep 2001 13:40:32 -0400
From: Ben Collins <bcollins@debian.org>
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] modutils: ieee1394 device_id extraction
Message-ID: <20010915134031.W8723@visi.net>
In-Reply-To: <m38zfgmohp.fsf@dk20037170.bang-olufsen.dk> <20010915121233.U8723@visi.net> <m34rq4mnaa.fsf@dk20037170.bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34rq4mnaa.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2001 at 06:28:13PM +0200, Kristian Hogsberg wrote:
> Ben Collins <bcollins@debian.org> writes:
> 
> > On Sat, Sep 15, 2001 at 06:02:10PM +0200, Kristian Hogsberg wrote:
> > > 
> > > Hi,
> > > 
> > > I've been adding hotplug support to the ieee1394 subsystem, and the
> > > ieee1394 stack in cvs now calls the usermode helper just like usb, pci
> > > and the rest of them.  Next step is to extend depmod so it extracts
> > > the device id tables from the 1394 device drivers, which is exactly
> > > what the patch below does.
> > > 
> > > Keith, would you apply this to modutils?
> > 
> > Any ETA on converting the sbp2 driver to the hotplug/nodemgr interfaces?
> > I can either sync the current CVS with Linus as-is, or wait till that is
> > done, if you think it will be done soon.
> 
> I think you should merge it as-is.  The sbp2 driver will still work
> with the hotplug system, it just does it's own probing now.  As for
> the ETA, I'll be working on it this weekend, so I hope to have
> something ready soon.

Ok, I'll merge the current code then.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
