Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSLHWxz>; Sun, 8 Dec 2002 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLHWxz>; Sun, 8 Dec 2002 17:53:55 -0500
Received: from holomorphy.com ([66.224.33.161]:16022 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261799AbSLHWxy>;
	Sun, 8 Dec 2002 17:53:54 -0500
Date: Sun, 8 Dec 2002 15:01:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
Message-ID: <20021208230109.GZ9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>,
	Manfred Spraul <manfred@colorfullife.com>, anton@samba.org,
	linux-kernel@vger.kernel.org
References: <3DF3B7FB.9010902@colorfullife.com> <20021208212808.GY9882@holomorphy.com> <1039389778.13079.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039389778.13079.1.camel@rth.ninka.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 13:28, William Lee Irwin III wrote:
>> Hmm. What happened to that pipe buffer size increase patch? That sounds
>> like it might help here, but only if those things are trying to shove
>> more than 4KB through the pipe at a time.

On Sun, Dec 08, 2002 at 03:22:58PM -0800, David S. Miller wrote:
> You probably mean the zero-copy pipe patches, which I think really
> should go in.  The most recent version of the diffs I saw didn't
> use the zero copy bits unless the trasnfers were quite large so it
> should be ok and not pessimize small transfers.
> That patch has been gathering cobwebs for more than a year now when I
> first did it, let's push this in already :-)

I was actually referring to one that explicitly used larger pipe
buffers, but this sounds useful too.


Bill
