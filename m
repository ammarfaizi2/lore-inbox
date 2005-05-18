Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVERNZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVERNZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVERNZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:25:44 -0400
Received: from [83.79.10.174] ([83.79.10.174]:57206 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S262140AbVERNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:25:37 -0400
Date: Wed, 18 May 2005 15:21:49 +0200
From: Karel Kulhavy <clock@twibright.com>
To: ross@jose.lug.udel.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
Message-ID: <20050518132149.GB13695@kestrel>
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe> <20050517192412.GA19431@kestrel.twibright.com> <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu> <20050518063014.GA7053@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518063014.GA7053@jose.lug.udel.edu>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 02:30:14AM -0400, ross@jose.lug.udel.edu wrote:
> On Tue, May 17, 2005 at 04:27:44PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > I was hoping somebody would explain how to get 'dmix' plugin working in the
> > kernel - then I could get rid of esd ;)  (Note that running something in
> > userspace that accepts connections, runs dmix on them, and then creates one
> > thing spewing to /dev/pcm isn't a solution - I've already *got* esd, warts and all)
> 
> 
> In all honesty - don't bother.  esd does the job better, faster, more
> flexibly, and without the hassle.

Is there some generic in-kernel support for mixing? I couldn't make
any of the userspace programs work.

I tried esd and it does the same as without esd - only one app gets to
the sound and the other waits.  The only difference was only (horrible)
increase in sound latency.

Installed esd in gentoo by emerge, then added into the startiup scripts,
/etc/init.d/esd start, switched xmms over to esd and skype on start said
"using esd". 

I would like to just run two sound programs concurrently. (Linux is a
time-sharing operating system, right?) I am not interested in a delay
line sound effect.

I also tried artsd and jack, but didn't succeed too.

CL<
