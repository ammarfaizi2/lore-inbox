Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270428AbTGSBiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 21:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbTGSBiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 21:38:15 -0400
Received: from zeus.kernel.org ([204.152.189.113]:41141 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270428AbTGSBiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 21:38:14 -0400
Subject: Re: Linux 2.4.22-pre7
From: Andre Tomt <andre@tomt.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030719003824.GI2289@matchmail.com>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
	 <1058569601.544.1.camel@teapot.felipe-alfaro.com>
	 <20030719003824.GI2289@matchmail.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1058575991.3407.117.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 02:53:11 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 01:06:41AM +0200, Felipe Alfaro Solana wrote:
> > 
> > Will ACL/xattr support get its way onto mainstream 2.4 soon?

> On l?, 2003-07-19 at 02:38, Mike Fedyk wrote:
> Doubt it.
> 
> Unless it gets into -ac or -aa for a long while and a whole bunch of users
> clamor for it.
> 
> So, is acl only working with ext[23] & XFS?  What about reiserfs or jfs?

There is one patch floating around for reiserfs, but thats probably
_very_ unofficial code. JFS, no idea.

> I was thinking of giving the acl patch a try one of these days.  There are a
> couple things where the ugo model doesn't work at my company.

I've been using it for 1-2 years now in a few production setups, never
had any problems with it. That is, other than waiting for a new release
or doing a dirty forwardport myself breaking things each time mainstream
2.4 updates. The distro's I use also ships libraries to support it :-)

-- 
Cheers,
André Tomt
andre@tomt.net

