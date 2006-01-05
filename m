Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752239AbWAEWCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbWAEWCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAEWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:02:28 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:4625 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1752234AbWAEWCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:02:01 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 5 Jan 2006 16:20:19 -0500
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Cc: Florian Schmidt <tapas@affenbande.org>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060105212019.GA23780@voodoo>
Mail-Followup-To: Marcin Dalecki <dalecki.marcin@neostrada.pl>,
	Florian Schmidt <tapas@affenbande.org>, Takashi Iwai <tiwai@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
	Olivier Galibert <galibert@pobox.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	perex@suse.cz, alsa-devel@alsa-project.org,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
	zaitcev@yahoo.com, linux-kernel@vger.kernel.org
References: <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <20060104113726.3bd7a649@mango.fruits.de> <s5hsls398uv.wl%tiwai@suse.de> <20060104191750.798af1da@mango.fruits.de> <74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/06 08:28:59PM +0100, Marcin Dalecki wrote:
> 
> On 2006-01-04, at 19:17, Florian Schmidt wrote:
> >Maybe create a /proc control, so users can revert
> >to the olde behaviour if there really is any need.
> 
> YES YES! After all who doesn't use his system logged in as root?

You can change the rights and ownership of files in /proc, so distributions
that use something like pam_console could change them when someone logs in.
That and most people know that poking around in /proc generally requires
root priviledges so making them use su or sudo wouldn't be a surprise.

Jim.
