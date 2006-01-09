Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWAIQVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWAIQVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAIQVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:21:13 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:19332 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S964845AbWAIQVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:21:11 -0500
Date: Mon, 9 Jan 2006 18:21:06 +0200
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
Message-ID: <20060109162106.GW21365@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20060104113726.3bd7a649@mango.fruits.de> <1136445395.24475.17.camel@mindpipe> <20060105124317.2d12a85c@mango.fruits.de> <1136483330.31583.5.camel@mindpipe> <20060108210756.GD1686@vianova.fi> <1136756669.2997.2.camel@mindpipe> <20060109081646.GG21365@vianova.fi> <1136814731.9957.4.camel@mindpipe> <20060109142239.GR21365@vianova.fi> <1136819894.9957.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136819894.9957.16.camel@mindpipe>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 10:18:13AM -0500, you [Lee Revell] wrote:
> 
> Since ALSA 1.0.9 (alsa-lib and alsa-driver > 1.0.9 required) no special
> configuration is required to get software mixing to work for i815 (and
> other chipsets which lack hardware mixing), with a few exception like
> ICE1712 and ICE1724 where a more complex configuration was required due
> to hardware restrictions.
> 
> You should never have to touch an .asoundrc file to get software mixing
> to work, if you do it's a bug.

When I tried with i815, my ALSA version might have been <= 1.0.9. 

Revo51 is ICE1724 based. I gather I still need the asoundrc config to get
some kind of mixing, right? At least it doesn't work without (and with it,
it badly stutters right now.)



-- v -- 

v@iki.fi

