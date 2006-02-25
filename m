Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWBYPbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWBYPbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWBYPbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:31:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161009AbWBYPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:31:23 -0500
Date: Sat, 25 Feb 2006 16:31:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Subject: Re: [v4l-dvb-maintainer] Re: kbuild: Section mismatch warnings
Message-ID: <20060225153121.GS3674@stusta.de>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org> <20060219125924.GB5896@linuxtv.org> <20060219131953.GA9744@mars.ravnborg.org> <20060219133039.GA11946@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219133039.GA11946@linuxtv.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 02:30:39PM +0100, Johannes Stezenbach wrote:
> On Sun, Feb 19, 2006 at 02:19:53PM +0100, Sam Ravnborg wrote:
> > On Sun, Feb 19, 2006 at 01:59:24PM +0100, Johannes Stezenbach wrote:
> > > ...
> > > > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xcaa6) and 'av7110_detach'
> > > > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xcbc5) and 'av7110_irq'
> > > 
> > > These seem to be legitimate and point to the right place.
> > > Patch attached.
> > 
> > Thanks Johannes.
> > I assume you will carry the patch in the dvb tree and push to linus.
> 
> Sure, after I corrected it (av7110_ir_init shouldn't be __devexit)

Could you submit this patch for 2.6.16.?

> Johannes

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

