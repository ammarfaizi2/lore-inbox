Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTDWRJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTDWRJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:09:22 -0400
Received: from pdbn-d9bb86a9.pool.mediaWays.net ([217.187.134.169]:57096 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S264120AbTDWRJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:09:21 -0400
Date: Wed, 23 Apr 2003 19:21:20 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423172120.GA12497@citd.de>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508310000.1051116963@flay>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:56:03AM -0700, Martin J. Bligh wrote:
> Actually, I agree with the submitter. Having the volume default to 0
> is stupid - userspace tools are all very well, but no substitute for
> sensible kernel defaults.

AFAIR ALSA always set the setting to zero.

I can only guess why. My buest guess is that not all
sound-configurations are the same, on some systems the "defaults" could
much to loud. (e.g. waking the neigbours when you restart you computer
at night)

I can perfectly understand the ALSA-guys. It's a bit annoying, but
nothing an init-script can't fix. -> Distro problem.
(And i guess the "OSS-gab" was filled by the Distro)

(Personally i use my own "S99misc" init-script which, apart from some other
things, loads the sound-driver and then sets the mixer-levels.)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

