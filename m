Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWI1FC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWI1FC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWI1FC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:02:57 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:4939 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751578AbWI1FC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:02:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SL6QjIkTKKBtP5O/bDPmGPXDCjzneOhEx+9rNy1yRIDx87XPMGExBqk7GX2w9jAPMREK8rNMEtej0say54WUSnZOkm3APZ7v+O6Rs/eQw4w5mfv7QHoMK8/8h5ECtcNUnVgBeeDOLP5DMHpWb1DYeXi9hhU8+NKI6SBz0OYOiek=
Message-ID: <a44ae5cd0609272202q140b4a91jef19afc6f0e2f090@mail.gmail.com>
Date: Wed, 27 Sep 2006 22:02:50 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Cc: "Andrew Morton" <akpm@osdl.org>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
In-Reply-To: <9a8748490609271724y5f39c57s889f94986e119e6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	 <20060926124310.17797fe5.akpm@osdl.org>
	 <a44ae5cd0609261753t311a7952w2a98434c093ef1c@mail.gmail.com>
	 <9a8748490609271724y5f39c57s889f94986e119e6d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 27/09/06, Miles Lane <miles.lane@gmail.com> wrote:
> > On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > [added netdev]
> > >
> > > On Tue, 26 Sep 2006 12:04:40 -0700
> > > "Miles Lane" <miles.lane@gmail.com> wrote:
> > >
> > > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > > info_element->len+2=28 left=9, id=221.
> > > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > > info_element->len+2=28 left=9, id=221.
> > > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > > info_element->len+2=28 left=9, id=221.
> > > >
> > > > >From dmesg output:
> > > > ieee80211: 802.11 data/management/control stack, git-1.1.13
> > > > ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> > > > ieee80211_crypt: registered algorithm 'NULL'
> > > > ieee80211_crypt: registered algorithm 'WEP'
> > > > ieee80211_crypt: registered algorithm 'CCMP'
> > > > ieee80211_crypt: registered algorithm 'TKIP'
> > >
> > > I suspect that whatever caused this is now in mainline.  Are you able to
> > > test Linus's current git tree?
> >
> > Sorry, I don't have oodles of disk space free to hold all the git
> > historical information (iirc, it's huge).
> [snip]
>
> You could just grab the latest snapshot (at the time of this writing
> that's 2.6.18-git8) from kernel.org - that way you wouldn't get all
> the historical git data.

Thanks Jesper.  I'll test this when I am back in the airport in a few days.
I'll add in the packet dump, if it's reproducible with 2.6.18-mm1.

    Miles
