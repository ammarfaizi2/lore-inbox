Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWELKUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWELKUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWELKUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:20:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53441 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751139AbWELKUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:20:48 -0400
Date: Fri, 12 May 2006 12:20:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       trenn@suse.de, thoenig@suse.de, stable@kernel.org
Subject: Re: [patch] smbus unhiding kills thermal management
Message-ID: <20060512102004.GD28232@elf.ucw.cz>
References: <20060512095343.GA28375@elf.ucw.cz> <44645FC2.80500@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44645FC2.80500@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 12-05-06 12:13:22, Carl-Daniel Hailfinger wrote:
> Hi!
> 
> Pavel Machek wrote:
> > Do not enable the SMBus device on Asus boards if suspend
> > is used. We do not reenable the device on resume, leading to all sorts
> > of undesirable effects, the worst being a total fan failure after
> > resume on Samsung P35 laptop.
> > 
> > Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> This is probably also -stable material.

Yes, I'd like to see it go into -stable. (But IIRC stable rules were
"mainline first").
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
