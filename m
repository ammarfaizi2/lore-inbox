Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933162AbWKMXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbWKMXYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbWKMXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:24:12 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:10246 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S933162AbWKMXYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:24:10 -0500
Date: Mon, 13 Nov 2006 18:22:41 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061113232241.GH4824@voodoo.jdc.home>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <1163374762.5178.285.camel@gullible> <1163404727.15249.99.camel@laptopd505.fenrus.org> <1163443887.5313.27.camel@mindpipe> <1163449139.15249.197.camel@laptopd505.fenrus.org> <20061113221611.GG4824@voodoo.jdc.home> <1163458748.5313.74.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163458748.5313.74.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06 05:59:08PM -0500, Lee Revell wrote:
> On Mon, 2006-11-13 at 17:16 -0500, Jim Crilly wrote:
> > I know that Debian ships both because I have to switch back to the OSS
> > driver whenever I want to play one of those closed source games that
> > mmap /dev/dsp because the ALSA OSS emulation can't seem to handle
> > having the device opened via ALSA and /dev/dsp at the same time and
> > the aoss wrapper doesn't work for apps that use mmap on /dev/dsp.
> > 
> 
> This should work with the ALSA /dev/dsp emulation, if you kill all other
> sound using apps before launching the game (which the OSS driver also
> requires).
> 

Well it doesn't and the only error I get from the game is:

/dev/dsp: Input/output error
Could not mmap /dev/dsp

If it makes a difference, lspci lists the card as:

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
Controller (rev a2)


Jim.
