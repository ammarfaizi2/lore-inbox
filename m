Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWBSNUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWBSNUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWBSNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 08:20:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51972 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932427AbWBSNUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 08:20:36 -0500
Date: Sun, 19 Feb 2006 14:19:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Johannes Stezenbach <js@linuxtv.org>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Subject: Re: [v4l-dvb-maintainer] Re: kbuild: Section mismatch warnings
Message-ID: <20060219131953.GA9744@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org> <20060219125924.GB5896@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219125924.GB5896@linuxtv.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:59:24PM +0100, Johannes Stezenbach wrote:
> ...
> > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xcaa6) and 'av7110_detach'
> > WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xcbc5) and 'av7110_irq'
> 
> These seem to be legitimate and point to the right place.
> Patch attached.

Thanks Johannes.
I assume you will carry the patch in the dvb tree and push to linus.

	Sam
