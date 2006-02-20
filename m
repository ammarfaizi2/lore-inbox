Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWBTLUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWBTLUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWBTLUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:20:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4048 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932567AbWBTLUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:20:49 -0500
Date: Mon, 20 Feb 2006 12:20:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220112032.GG16042@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz> <20060220094728.GD19293@kobayashi-maru.wspse.de> <20060220105617.GF16042@elf.ucw.cz> <20060220111756.GC22552@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220111756.GC22552@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 12:17:56, Matthias Hensler wrote:
> Hi.
> 
> On Mon, Feb 20, 2006 at 11:56:17AM +0100, Pavel Machek wrote:
> > On Po 20-02-06 10:47:28, Matthias Hensler wrote:
> > > I do not think that Suspend 2 needs 14000 lines for that, the core
> > > is much smaller. But besides, _not_ saving the pagecache is a really
> > > _bad_ idea. I expect to have my system back after resume, in the
> > > same state I had left it prior to suspend. I really do not like it
> > > how it is done by Windows, it is just ugly to have a slowly
> > > responding system after resume, because all caches and buffers are
> > > gone.
> > 
> > That's okay, swsusp already saves configurable ammount of pagecache.
> 
> What about uswsusp?

Same code is used for that.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
