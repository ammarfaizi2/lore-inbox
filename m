Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVADWET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVADWET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVADWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:04:06 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:31752 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262378AbVADWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:02:56 -0500
Date: Tue, 4 Jan 2005 23:01:44 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, davidsen@tmr.com,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104220144.GA2901@pclin040.win.tue.nl>
References: <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104195725.GQ2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104195725.GQ2708@holomorphy.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 11:57:25AM -0800, William Lee Irwin III wrote ...

> > ... An example is CONFIG_BLK_DEV_UB in 2.6.9, which ...
> 
> PEBKAC is entirely out of the scope of any program not making direct
> efforts at HCI. CONFIG_BLK_DEV_UB was documented for what it was, and
> users configuring kernels are not assumed to be naive.

Hmm. Let me disagree again.
The kernel configuration process is intended for the average person
who configures kernels. When there are many complaints (as I recall
from 2.5 times, where one needed to figure out how to get keyboard
and mouse configured) then it is no good to tell the world
"you are all stupid, just read the docs" - one needs to think about
how the setup can be improved so that fewer people have difficulties.


-----
This was part of a discussion about 2.6 vs 2.7. Every single
user-visible change will cause problems for some people.

Earlier we talked about fixing bugs. You sounded as if you
considered fixing one particular bug a point event, while
I preferred to regard it as a process of unknown duration.
A problem is noticed, a fix is made, somewhat later one finds
that the fix has unintended side effects and the fix is
modified slightly, etc. One consequence of this is that
the bug fixing process for a rare bug that affects few people
may affect many.

What users hope for is a situation like with TeX.
It has version numbers like 3.14159, tending to pi.
This conveys the intention: in principle TeX is fixed,
but flaws are corrected.
A kernel like 2.2 should converge to a limit, with big changes
in the beginning, and only tiny changes later on.

If on the other hand there is continuous development, and
continuous bug fixing, there is continuous instability -
I do not mean instability in the sense of kernel crashes,
but instability in the sense of user-visible changes,
user setups that are broken. This makes users unhappy.


Andries
