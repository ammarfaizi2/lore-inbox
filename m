Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTDXOwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTDXOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:52:21 -0400
Received: from almesberger.net ([63.105.73.239]:19721 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263727AbTDXOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:52:20 -0400
Date: Thu, 24 Apr 2003 12:04:03 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Pat Suwalski <pat@suwalski.net>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424120403.N3557@almesberger.net>
References: <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424134904.GA18149@citd.de> <3EA7EFF5.3060900@suwalski.net> <20030424143433.GA18374@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424143433.GA18374@citd.de>; from ms@citd.de on Thu, Apr 24, 2003 at 04:34:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Maybe it depends on hardware, or your mixer "transparently" unmutes the
> channel when you increase volume.

Hmm, KMix doesn't do either, but if I mute the main volume and
restart KMix, it will come up unmuted, but the volume set to
zero.

Other mixers (XMixer, aumix) don't seem know of the concept of
muting at all. (And switching input sources doesn't seem to
have much effect on what gets sent to the speakers.)

Also, a quick grep through linux-*/sound/ doesn't find the
word "mute". Are you sure this isn't a feature of the mixer
instead of the sound API ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
