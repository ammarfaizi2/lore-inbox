Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUIGJHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUIGJHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUIGJHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:07:50 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:43433 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267497AbUIGJHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:07:48 -0400
Message-ID: <d577e5690409070207448961a4@mail.gmail.com>
Date: Tue, 7 Sep 2004 05:07:45 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	"Michel  =?ISO-8859-1?Q?=20D=E4nzer=22?= <michel@daenzer.net>"
			^-missing closing '"' in token
Subject: Re: [BUG] r200 dri driver deadlocks
Cc: Lee Revell <rlrevell@joe-job.com>, dri-devel@lists.sf.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1094494329.31464.187.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
	 <1094429682.29921.6.camel@krustophenia.net>
	 <d577e569040906040147c2277f@mail.gmail.com>
	 <1094494329.31464.187.camel@admin.tel.thor.asgaard.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)

On Mon, 06 Sep 2004 14:12:08 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> You can test the r200_dri.so from the snapshot with the DRM from the
> kernel...

And drum roll please...

The dri cvs snapshot works fine on both it's own kernel module, and
the one that comes
with 2.6.8.1. So now what? (And does this mean it isn't a kernel bug?)

<rant>
Also, what happens to r200 users who happen to use Debian? Using dri
cvs snapshots
obviously isn't an option for everyone (though I don't mind at all)
and upgrading to Xorg
(when Xorg gets this fix if it doesn't already) is even less of an
option. The official word
from the Debian X Strike Force is not to switch to Xorg until debriX
(modular X) gets
somewhere.
</rant>

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
