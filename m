Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWKOUEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWKOUEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbWKOUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:04:12 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:44966
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161382AbWKOUEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:04:11 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Pavel Roskin <proski@gnu.org>
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Date: Wed, 15 Nov 2006 21:02:26 +0100
User-Agent: KMail/1.9.5
References: <20061115031025.GH3451@tuxdriver.com> <20061115192054.GA10009@tuxdriver.com> <1163619541.19111.6.camel@dv>
In-Reply-To: <1163619541.19111.6.camel@dv>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       madwifi-devel@lists.sourceforge.net, lwn@lwn.net,
       "John W. Linville" <linville@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152102.26681.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 20:39, Pavel Roskin wrote:
> Hello!
> 
> On Wed, 2006-11-15 at 14:21 -0500, John W. Linville wrote:
> > On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> > 
> > > Now that it seems to be ok to use these openbsd sources, should I port
> > > them to my driver framework?
> > > I looked over the ar5k code and, well, I don't like it. ;)
> > > I don't really like having a HAL. I'd rather prefer a "real" driver
> > > without that HAL obfuscation.
> > 
> > I don't think anyone likes the HAL-based architecture.  I don't think
> > we will accept a HAL-based driver into the upstream kernel.
> 
> I said it before, and it's worth repeating.  Dissolving HAL in the
> sources is easy.  It's just a matter of moving functions around without
> serious chances of breaking anything as long as the source compiles.
> The whole "HAL-based architecture" can be reshuffled and eliminated by
> one person in a few days.

I'll look at it tomorrow.
Probably best to merge this stuff into the tree somehow to get it
working and clean it up afterwards. Shouldn't be too hard to merge.

> Making things work properly takes years.  That's what MadWifi has been
> working on for a long time, using contributions and bug reports from
> scores of users and developers.
> 
> Rejecting MadWifi because it's HAL based is like throwing away a diamond
> ring because it's too narrow.

Well, it never worked for me. But I gave up trying about
half a year ago. But maybe it's just stupid me. ;)

-- 
Greetings Michael.
