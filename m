Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbTDIGai (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbTDIGai (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:30:38 -0400
Received: from unthought.net ([212.97.129.24]:14786 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id S262837AbTDIGah (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 02:30:37 -0400
Date: Wed, 9 Apr 2003 08:42:15 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
Message-ID: <20030409064215.GC10141@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Andrew Morton <akpm@digeo.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com> <20030406182435.5a243297.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030406182435.5a243297.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 06:24:35PM -0700, Andrew Morton wrote:
...
> the patch below fixes George's setiathome problems (as expected).  It
> essentially turns off Linus' improvement, but i dont think it can be fixed
> sanely.
> 
> the problem with setiathome is that it displays something every now and
> then - so it gets a backboost from X, and hovers at a relatively high
> priority.

Why are niced processes boosted?   Does that make sense?

If only non-niced processes were boosted, wouldn't that pretty much fix
the problem?

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
