Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTLMIhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 03:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTLMIhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 03:37:00 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:14754 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264508AbTLMIg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 03:36:58 -0500
Date: Sat, 13 Dec 2003 09:36:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031213083654.GA32110@ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com> <20031212223128.GA15935@mail.shareable.org> <20031212225856.GA30751@ucw.cz> <20031212234523.GE15935@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212234523.GE15935@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 11:45:23PM +0000, Jamie Lokier wrote:
> Vojtech Pavlik wrote:
> > > > I'd advocate lower HZ. Say, oh I dunno...100? This is better for power
> > > > management and also should make the sound go away.
> > > 
> > > Alas, the sound my Toshiba laptop makes when the CPU is busy is the
> > > same frequency whatever kernel, and by extension whatever the timer
> > > frequency.  I guess it must have another cause :/
> >
> > If it's when the CPU is busy, then it's the CPU's DC/DC converter. There
> > is no way to get rid of the noise without mnodifying the notebook.
> 
> It only does it when the CPU is busy in any low power mode.  In
> maximum power mode it never makes the noise.  It sounds like it's
> coming from the speakers (independent of volume control though), but
> it might not be.
> 
> Would the DC/DC converter noise be explained by a low quality
> capacitor used by the converter?

Yes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
