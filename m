Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWADT4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWADT4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWADT4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:56:09 -0500
Received: from affenbande.org ([81.169.150.36]:13698 "EHLO
	tarzan.affenbande.org") by vger.kernel.org with ESMTP
	id S1030271AbWADT4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:56:07 -0500
Date: Wed, 4 Jan 2006 20:52:32 +0100
From: Florian Schmidt <tapas@affenbande.org>
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
Message-ID: <20060104205232.1dd5f308@mango.fruits.de>
In-Reply-To: <74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
References: <s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<20060103221314.GB23175@irc.pl>
	<20060103231009.GI3831@stusta.de>
	<Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	<20060104000344.GJ3831@stusta.de>
	<Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	<20060104010123.GK3831@stusta.de>
	<Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	<20060104113726.3bd7a649@mango.fruits.de>
	<s5hsls398uv.wl%tiwai@suse.de>
	<20060104191750.798af1da@mango.fruits.de>
	<74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
Organization: affenbande
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 20:28:59 +0100
Marcin Dalecki <dalecki.marcin@neostrada.pl> wrote:

> 
> On 2006-01-04, at 19:17, Florian Schmidt wrote:
> > Maybe create a /proc control, so users can revert
> > to the olde behaviour if there really is any need.
> 
> YES YES! After all who doesn't use his system logged in as root?

Well, maybe it is a bad idea. Got a better one up your sleeve? Or just
sarcasm? 

Maybe make it a .asoundrc option (which libasound reads everytime a
device is opened anyways). Maybe even per device.

Flo
