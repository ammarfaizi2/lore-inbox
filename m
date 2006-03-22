Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWCVRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWCVRyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWCVRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:54:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932252AbWCVRyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:54:33 -0500
Date: Wed, 22 Mar 2006 12:54:26 -0500
From: Dave Jones <davej@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresolved emu10k1 synth symbols.
Message-ID: <20060322175426.GA1188@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060321054634.GA5122@redhat.com> <s5hoe0083ek.wl%tiwai@suse.de> <20060321180957.GB5323@redhat.com> <s5hd5geh8ds.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd5geh8ds.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 03:16:47PM +0100, Takashi Iwai wrote:
 > At Tue, 21 Mar 2006 13:09:57 -0500,
 > Dave Jones wrote:
 > > 
 > > On Tue, Mar 21, 2006 at 12:04:35PM +0100, Takashi Iwai wrote:
 > > 
 > >  > Weird.  By modprobe, snd-emu10k1 module should be loaded in prior to 
 > >  > snd-emu10k1-synth because of the dependency of above symbols.
 > >  > 
 > >  > How is snd-emu10k1-synth module loaded?
 > > 
 > > with the following modprobe.conf fragment
 > > 
 > > install snd-emu10k1 /sbin/modprobe --ignore-install snd-emu10k1 && /sbin/modprobe snd-emu10k1-synth
 > 
 > Does the manual modprobe snd-emu10k1-synth after loading snd-emu10k1
 > work?

Yes, it does.

		Dave

-- 
http://www.codemonkey.org.uk
