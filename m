Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTLLXpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLLXpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:45:31 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:36227 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264445AbTLLXp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:45:27 -0500
Date: Fri, 12 Dec 2003 23:45:23 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212234523.GE15935@mail.shareable.org>
References: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com> <20031212223128.GA15935@mail.shareable.org> <20031212225856.GA30751@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212225856.GA30751@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> > > I'd advocate lower HZ. Say, oh I dunno...100? This is better for power
> > > management and also should make the sound go away.
> > 
> > Alas, the sound my Toshiba laptop makes when the CPU is busy is the
> > same frequency whatever kernel, and by extension whatever the timer
> > frequency.  I guess it must have another cause :/
>
> If it's when the CPU is busy, then it's the CPU's DC/DC converter. There
> is no way to get rid of the noise without mnodifying the notebook.

It only does it when the CPU is busy in any low power mode.  In
maximum power mode it never makes the noise.  It sounds like it's
coming from the speakers (independent of volume control though), but
it might not be.

Would the DC/DC converter noise be explained by a low quality
capacitor used by the converter?

-- Jamie

