Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274224AbRIXWoa>; Mon, 24 Sep 2001 18:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274225AbRIXWoU>; Mon, 24 Sep 2001 18:44:20 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:39952 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274224AbRIXWoH>; Mon, 24 Sep 2001 18:44:07 -0400
Date: Tue, 25 Sep 2001 00:44:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Grant <davidgrant79@hotmail.com>, Greg Ward <gward@python.net>,
        bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010925004431.A197@suse.cz>
In-Reply-To: <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com> <20010922110945.B678@gerg.ca> <OE48GTjkifTNRMOKS310000192c@hotmail.com> <20010924103544.A1572@suse.cz> <m1k7yo77v7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1k7yo77v7.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Sep 24, 2001 at 12:37:32PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 12:37:32PM -0600, Eric W. Biederman wrote:

> > The PnP stuff is for ISA PnP cards. If you don't have those, it's
> > irrelevant. When "PnP OS Installed" is set to "No", the BIOS does the
> > ISAPnP initialization. If it is set to "Yes", it skips that step. Linux
> > prefers to have the ISAPnP cards pre-initialized, though it can do it
> > all by itself.
> 
> "PnP OS Installed" applies to PCI as well as ISA PnP.  The rule is
> something like all possible boot devices must be initialized but that
> is all. 

Well, I know of no BIOS that would, with PnP OS Installed set to Yes not
configure all PCI cards in the system.

-- 
Vojtech Pavlik
SuSE Labs
