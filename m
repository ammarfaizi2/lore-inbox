Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCNISI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCNISI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCNISI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:18:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53965 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261332AbVCNISF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:18:05 -0500
Date: Mon, 14 Mar 2005 09:17:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050314081721.GA13817@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp> <20050311222614.GH4185@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050311222614.GH4185@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 11-03-05 17:26:14, Dave Jones wrote:
> On Sat, Mar 12, 2005 at 07:18:19AM +0900, OGAWA Hirofumi wrote:
>  > Linus Torvalds <torvalds@osdl.org> writes:
>  > 
>  > > Hmm.. We seem to not have any tests for the counts becoming negative, and
>  > > this would seem to be an easy mistake to make considering that both I and 
>  > > Dave did it.
>  > 
>  > I stole this from -mm.
> 
> I'm fascinated that not a single person picked up on this problem
> whilst the agp code sat in -mm. Even if DRI isn't enabled,
> every box out there with AGP that uses the generic routines
> (which is a majority), should have barfed loudly when it hit
> this check during boot.  Does no-one read dmesg output any more ?

Its way too long these days. Like "so long it overflows even enlarged
buffer". We should prune these messages down to "one line per hw
device or serious problems only".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
