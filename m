Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVG1BeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVG1BeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVG1Bc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:32:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32486 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261505AbVG1BbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:31:19 -0400
Subject: Re: 2.6.12: no sound on SPDIF with emu10k1
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1122513715.13792.22.camel@hostmaster.org>
References: <1122493585.3137.14.camel@hostmaster.org>
	 <1122497052.22844.5.camel@mindpipe>
	 <1122513715.13792.22.camel@hostmaster.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 21:31:17 -0400
Message-Id: <1122514277.22844.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 03:21 +0200, Thomas Zehetbauer wrote:
> On Wed, 2005-07-27 at 16:44 -0400, Lee Revell wrote:
> > On Wed, 2005-07-27 at 21:46 +0200, Thomas Zehetbauer wrote:
> > > I cannot get my SB Live! 5.1's SPDIF (digital) output to work with
> > > kernel > 2.6.12. I have not changed my mixer configuration and it is
> > > still working when I boot 2.6.11.12 or earlier. I am using FC4 with
> > > alsa-lib-1.0.9rf-2.FC4 installed.
> > 
> > FC4 shipped a buggy ALSA version, I can't believe there are no updated
> > RPMs yet.
> > 
> > You need a newer ALSA.
> 
> alsa-lib-1.0.9rf-2 is the latest update available:
> http://download.fedora.redhat.com/pub/fedora/linux/core/updates/4/x86_64/alsa-lib-1.0.9rf-2.FC4.x86_64.rpm
> 
> If FC4's ALSA was really broken, I wonder why it is working fine with
> kernel 2.6.11.12 and earlier?

If upgrading other ALSA packages does not work, see if it works with
ALSA CVS (alsa-lib, alsa-utilsm, and alsa-kernel).

Also, even though you said you did not change it, check your mixer
configuration again - there was a change to that driver that could have
caused some users to lose mixer settings (newer versions of alsactl work
around it).

Lee

