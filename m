Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbRFKJO5>; Mon, 11 Jun 2001 05:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263584AbRFKJOr>; Mon, 11 Jun 2001 05:14:47 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263578AbRFKJOl>;
	Mon, 11 Jun 2001 05:14:41 -0400
Date: Fri, 8 Jun 2001 20:06:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010608200653.D36@toy.ucw.cz>
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr> <Pine.LNX.4.33.0106061814470.1655-100000@cheetah.psv.nu> <9fm4sc@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9fm4sc@cesium.transmeta.com>; from hpa@zytor.com on Wed, Jun 06, 2001 at 01:47:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Kelvin (decikelvin?) is probably a good unit to use in the kernel. If you
> > want something else you convert it in the programs you use to interact
> > with the kernel. This is a usespace issue, I think.
> > 
> 
> Decikelvins is a good bet if we feel that fitting into 16 bits is a
> necessary, or the width of things is limited.  Otherwise I would go
> for millikelvins on the general principle that creating interfaces too
> narrow is really painful.

Actually there's one good reasons to use milikelvins:

0 Celsius != 2732 deciKelvin, but
0 Celsius == 273150 miliKelvin ;-)
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

