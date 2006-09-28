Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031287AbWI1AY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031287AbWI1AY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031290AbWI1AY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:24:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:10851 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031289AbWI1AYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:24:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kX+Stk45/SzK1qyevkLXBdw9OIDl8MWC/EuCvbl8It3szLjqrglP0rh2bKZ6u3BybkpYiH9GGKq2tbd1DSOJ7///lkh834xSwPmjfTJSXVSmaAKsAvVU72GZdYEQ2GgEt49UedI7VErRXR3ij9TrbEmUEg129DjUBn51iHJFFC8=
Message-ID: <9a8748490609271724y5f39c57s889f94986e119e6d@mail.gmail.com>
Date: Thu, 28 Sep 2006 02:24:20 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Cc: "Andrew Morton" <akpm@osdl.org>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
In-Reply-To: <a44ae5cd0609261753t311a7952w2a98434c093ef1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	 <20060926124310.17797fe5.akpm@osdl.org>
	 <a44ae5cd0609261753t311a7952w2a98434c093ef1c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/06, Miles Lane <miles.lane@gmail.com> wrote:
> On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > [added netdev]
> >
> > On Tue, 26 Sep 2006 12:04:40 -0700
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> >
> > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > info_element->len+2=28 left=9, id=221.
> > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > info_element->len+2=28 left=9, id=221.
> > > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > > info_element->len+2=28 left=9, id=221.
> > >
> > > >From dmesg output:
> > > ieee80211: 802.11 data/management/control stack, git-1.1.13
> > > ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> > > ieee80211_crypt: registered algorithm 'NULL'
> > > ieee80211_crypt: registered algorithm 'WEP'
> > > ieee80211_crypt: registered algorithm 'CCMP'
> > > ieee80211_crypt: registered algorithm 'TKIP'
> >
> > I suspect that whatever caused this is now in mainline.  Are you able to
> > test Linus's current git tree?
>
> Sorry, I don't have oodles of disk space free to hold all the git
> historical information (iirc, it's huge).
[snip]

You could just grab the latest snapshot (at the time of this writing
that's 2.6.18-git8) from kernel.org - that way you wouldn't get all
the historical git data.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
