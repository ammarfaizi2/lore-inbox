Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTDYKSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDYKSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:18:33 -0400
Received: from almesberger.net ([63.105.73.239]:30732 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263711AbTDYKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:18:32 -0400
Date: Fri, 25 Apr 2003 07:30:27 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Matthias Schniedermeyer <ms@citd.de>, Pat Suwalski <pat@suwalski.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030425073027.U3557@almesberger.net>
References: <20030424182227.P3557@almesberger.net> <Pine.LNX.4.44.0304251202290.1347-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304251202290.1347-100000@pnote.perex-int.cz>; from perex@suse.cz on Fri, Apr 25, 2003 at 12:03:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> I would change this to 'OSS mixers' because all ALSA mixers handle the 
> mute feature.

I didn't qualify this for two reasons:

 - also an ALSA mixer may choose not to show a "mute" button (or
   equivalent) to the user
 - how am I to tell if my mixer is an ALSA or an OSS mixer ?

That's why I think a "if there's a mute button, set it to unmute,
if there's none, don't worry" rule is easier to understand.

I'd also expect that "mute" will sometimes be confused with input
selection (at least that happened to me, because I'm used to
XMixer and didn't realize there was another set of controls, e.g.
in KMix), but the rule will still work.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
