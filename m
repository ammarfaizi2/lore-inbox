Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280822AbRK0Pmv>; Tue, 27 Nov 2001 10:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRK0Pmi>; Tue, 27 Nov 2001 10:42:38 -0500
Received: from otter.mbay.net ([206.40.79.2]:4624 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280822AbRK0PmZ> convert rfc822-to-8bit;
	Tue, 27 Nov 2001 10:42:25 -0500
From: John Alvord <jalvo@mbay.net>
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Date: Tue, 27 Nov 2001 07:42:13 -0800
Message-ID: <10d70uc78emevo2h95o6ldhrdr2tgo656v@4ax.com>
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com> <20011126192902.M5770@khan.acc.umu.se> <3C028A8D.8040503@zytor.com> <20011126161802.A8398@xi.linuxpower.cx> <20011127154323.B513@Zenith.starcenter>
In-Reply-To: <20011127154323.B513@Zenith.starcenter>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 15:43:23 +0100, Sven Vermeulen
<sven.vermeulen@rug.ac.be> wrote:

>On Mon, Nov 26, 2001 at 04:18:02PM -0500, Gregory Maxwell wrote:
>> Why not just disguard this sillyness of alphabetic characters in version
>> numbers... Just carry through the same structure used by major/minor:
>> I.e.
>> 
>> 2.0.39 < released 2.0.39
>> 2.0.39.1.1 < first development snapshot of the kernel which will eventually
>> 	     be 2.0.40
>> 2.0.39.1.2 < second
>> 2.0.39.1.n < Nth
>> 2.0.39.2.1 < first RC
>> 2.0.39.2.2 < second RC
>> 2.0.39.3.1 < opps! Development went too long and we had to break feature
>> 	     freeze to add important features.
>> 2.0.39.4.1 < Trying to stablize again
>> 2.0.39.4.2 < a few more bugs fixxed
>> 2.0.40	   < Looks like 2.0.39.4.2 got it right!
>
>Some people may find this more "logical", but imho most will find it
>confusing... It's already difficult to inform someone about the
>(number).(even|odd).(release)-(patch|pre-final) scheme. I'm more into 
>	-pre: added some features, bugfixes etc...
>	-fc : feature-freeze, only bugfixes
>and having some time (f.i. 48h) between the last -fc and the "real" release
>(without having a single addendum to the ChangeLog).

The bug-fixes only would have to be tightly defined. All of
2.4.0-2.4.15 were bug-fixes in some sense... 

john

