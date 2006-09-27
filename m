Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWI0AxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWI0AxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWI0AxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:53:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:55867 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932100AbWI0AxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kbN+YPFfol0nMWk9RsORnqIo7kfS0umaB+c8ipl8M5JYvOq4CYjSnDmg6lSZtY8JkCdw9LW6qyQYON8ohXm5YrDPXdmXkp2W/Yfr0kOGszvr7pcCUHBwfFqLL+Kq/pxvJqkAQlp88LrRjcU8U428nb4D1EgmTeAMIcsmChI02qo=
Message-ID: <a44ae5cd0609261753t311a7952w2a98434c093ef1c@mail.gmail.com>
Date: Tue, 26 Sep 2006 17:53:10 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-mm1 -- ieee80211: Info elem: parse failed: info_element->len + 2 > left : info_element->len+2=28 left=9, id=221.
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       "Jouni Malinen" <jkmaline@cc.hut.fi>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
In-Reply-To: <20060926124310.17797fe5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609261204g673fbf8ft6809378930986eac@mail.gmail.com>
	 <20060926124310.17797fe5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
>
> [added netdev]
>
> On Tue, 26 Sep 2006 12:04:40 -0700
> "Miles Lane" <miles.lane@gmail.com> wrote:
>
> > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > info_element->len+2=28 left=9, id=221.
> > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > info_element->len+2=28 left=9, id=221.
> > ieee80211: Info elem: parse failed: info_element->len + 2 > left :
> > info_element->len+2=28 left=9, id=221.
> >
> > >From dmesg output:
> > ieee80211: 802.11 data/management/control stack, git-1.1.13
> > ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> > ieee80211_crypt: registered algorithm 'NULL'
> > ieee80211_crypt: registered algorithm 'WEP'
> > ieee80211_crypt: registered algorithm 'CCMP'
> > ieee80211_crypt: registered algorithm 'TKIP'
>
> I suspect that whatever caused this is now in mainline.  Are you able to
> test Linus's current git tree?

Sorry, I don't have oodles of disk space free to hold all the git
historical information (iirc, it's huge).  I could conceivably put it
together, but I'd been some help and time.  I am currently travelling,
but I do have my kernel test laptop with me.  Also, I am currently
staying in a building running off of solar power, so I need to be a
bit careful with power consumption.  I'll be in a place with AC power
in five days.  Lastly, I don't know how I triggered the problem.  I am
happy to try to reproduce it for you, though.

        Miles
