Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbWAHVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbWAHVIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWAHVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:08:04 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:24784 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932775AbWAHVID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:08:03 -0500
Date: Sun, 8 Jan 2006 23:07:56 +0200
From: Ville Herva <vherva@vianova.fi>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <tapas@affenbande.org>,
       Tomasz =?iso-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060108210756.GD1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <20060104113726.3bd7a649@mango.fruits.de> <1136445395.24475.17.camel@mindpipe> <20060105124317.2d12a85c@mango.fruits.de> <1136483330.31583.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136483330.31583.5.camel@mindpipe>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:48:49PM -0500, you [Lee Revell] wrote:
> On Thu, 2006-01-05 at 12:43 +0100, Florian Schmidt wrote:
> > BTW: Don't expect people to always write bug reports. We all know,
> > people are lazy. More often than not, they simply give up and say
> > "linux sucks" to their friends. Or if they can differentiate a little
> > more, they'll say "ALSA sucks" ;) [<- smiley, indicates humor].
> > Especially those who use closed source apps ;) 
> 
> Of course I don't expect every end user with a problem to file a bug
> report (although Mantis makes it much easier than Bugzilla) but I sure
> as hell expect people who complain about ALSA on LKML to.
> 
> Unless we get some useful bug reports out of it this thread is much ado
> about nothing.  Come on people, put up or shut up.
> 
> https://bugtrack.alsa-project.org/alsa-bug/main_page.php

I would love to make a useful bug report of dmix not working with M-Audio
Revolution 5.1 (it stutters so badly that it's unusable), but after hours of
twiddling with asoundrc I still can't figure out if I have it set up
correctly. Also, I can't get any sound out of headphone output. To me this
is a sign that perhaps the ALSA config scheme is a bit too complex, although
more probably, it's just me being too stupid to use it.

In perfect world, both headphone out and dmix should "just work". They do
"just work" with the OSS binary blob (as does mixing with applications that
use OSS API.)

With Intel i815 integrated sound, ALSA dmix does work.


-- v -- 

v@iki.fi

