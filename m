Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVERGaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVERGaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 02:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVERGaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 02:30:23 -0400
Received: from jose.lug.udel.edu ([128.175.60.112]:29127 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S262104AbVERGaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 02:30:15 -0400
From: ross@lug.udel.edu
Date: Wed, 18 May 2005 02:30:14 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Karel Kulhavy <clock@twibright.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
Message-ID: <20050518063014.GA7053@jose.lug.udel.edu>
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe> <20050517192412.GA19431@kestrel.twibright.com> <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 04:27:44PM -0400, Valdis.Kletnieks@vt.edu wrote:
> I was hoping somebody would explain how to get 'dmix' plugin working in the
> kernel - then I could get rid of esd ;)  (Note that running something in
> userspace that accepts connections, runs dmix on them, and then creates one
> thing spewing to /dev/pcm isn't a solution - I've already *got* esd, warts and all)


In all honesty - don't bother.  esd does the job better, faster, more
flexibly, and without the hassle.

I have spent many hours attempting to get a usable dmix setup working
and I just don't think its possible (at least not with my hardware).

I use esd for all "consumer" level audio apps, and jackd for all
professional audio apps.  This is by far the simplest way to manage
audio - I wouldn't waste your time with dmix.  After all, what could
you do with dmix that you can't do with esd??


-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
