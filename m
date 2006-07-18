Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWGRUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWGRUrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWGRUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:47:22 -0400
Received: from mail.gmx.net ([213.165.64.21]:27351 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932381AbWGRUrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:47:21 -0400
X-Authenticated: #428038
Date: Tue, 18 Jul 2006 22:47:18 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060718204718.GD18909@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Grzegorz Kulewski <kangur@polcom.net>,
	Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
	caleb@calebgray.com, linux-kernel@vger.kernel.org
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-07-18:

> Because that patch pokes into some files outside fs/reiser4, giving a hard time
> with rejects for the novice user. The linux kernel is a huge codebase, and 
> I have, for example, less clue of mm/ than of fs/.
> 
> I was very happy to see that
> ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.16/reiser4-for-2.6.16-4.patch.gz
> worked well on 2.6.17 and 2.6.17.x, but it already stopped patching again 
> on 2.6.18-rc1. The next newer version of reiser4 is for -mm, which is not 

Sorry, none of the kernel's business.

ISTR they have been asked to review/justify the bits outside fs/reiser4
and feed them separately where valuable and otherwise move or drop.

> so useful for me. If namesys provided reiser4 patches for every vanilla out 
> there (possibly including -rc's, but that's just extra sugar), that would 
> be great, but I cannot force them to do so; people may have better things 
> to do than packaging up r4 whenever there is a linux tarball release.

And probably kernel hackers have better things to do than keeping that
code building if they don't mean to support it. This touches the "stable
APIs" can of worms again, so let's stop here before it springs open.

- 
Matthias Andree
