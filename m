Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755374AbWKMWSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbWKMWSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbWKMWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:18:11 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:60431 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1755374AbWKMWSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:18:09 -0500
Date: Mon, 13 Nov 2006 17:16:11 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <20061113221611.GG4824@voodoo.jdc.home>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <1163374762.5178.285.camel@gullible> <1163404727.15249.99.camel@laptopd505.fenrus.org> <1163443887.5313.27.camel@mindpipe> <1163449139.15249.197.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163449139.15249.197.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06 09:18:59PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-11-13 at 13:51 -0500, Lee Revell wrote:
> > On Mon, 2006-11-13 at 08:58 +0100, Arjan van de Ven wrote:
> > > Now; there is a second issue. If the choice for one or the other is
> > > consistent, we should consider fixing the kernel drivers to just not
> > > advertise the b0rked one.. (this assumes that both drivers are in the
> > > kernel and both are open source) 
> > 
> > Unfortunately it becomes political quickly.  For example the old OSS
> > i810_audio driver is still in the kernel even though the ALSA driver
> > supports more hardware and provides more functionality because some
> > people consider the ALSA driver bloated.
> 
> I doubt distros ship both though.... I thought all distros were
> alsa-only by now..
> 

I know that Debian ships both because I have to switch back to the OSS
driver whenever I want to play one of those closed source games that mmap
/dev/dsp because the ALSA OSS emulation can't seem to handle having the
device opened via ALSA and /dev/dsp at the same time and the aoss wrapper
doesn't work for apps that use mmap on /dev/dsp.

Jim.
