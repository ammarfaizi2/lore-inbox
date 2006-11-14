Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933298AbWKNBPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbWKNBPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933300AbWKNBPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:15:30 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:39428 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S933298AbWKNBP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:15:29 -0500
Date: Mon, 13 Nov 2006 20:14:19 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061114011419.GI4824@voodoo.jdc.home>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <1163374762.5178.285.camel@gullible> <1163404727.15249.99.camel@laptopd505.fenrus.org> <1163443887.5313.27.camel@mindpipe> <1163449139.15249.197.camel@laptopd505.fenrus.org> <20061113221611.GG4824@voodoo.jdc.home> <1163458748.5313.74.camel@mindpipe> <20061113232241.GH4824@voodoo.jdc.home> <1163461501.8780.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163461501.8780.2.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06 06:45:01PM -0500, Lee Revell wrote:
> On Mon, 2006-11-13 at 18:22 -0500, Jim Crilly wrote:
> > Well it doesn't and the only error I get from the game is:
> > 
> > /dev/dsp: Input/output error
> > Could not mmap /dev/dsp
> > 
> > If it makes a difference, lspci lists the card as:
> > 
> > 00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
> > Audio Controller (rev a2) 
> 
> Please see http://www.alsa-project.org/~iwai/OSS-Emulation.html.
> 
> You need something like:
> 
> $ echo "quake 0 0 direct" > /proc/asound/card0/pcm0p/oss
> 

Yea, I've read that FAQ and I vaguely remember trying that although that
might have been for something different because it appears to be working
now. I can't actually verify the sound is working though since I'm not
physically at the box.

Sorry for the noise.

Jim.
