Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVAESLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVAESLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVAESLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:11:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34726 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262530AbVAESIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:08:49 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
In-Reply-To: <s5hhdlvyg6q.wl@alsa2.suse.de>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
	 <s5hhdlvyg6q.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 13:04:38 -0500
Message-Id: <1104948279.8589.42.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 17:49 +0100, Takashi Iwai wrote:
> At Wed, 5 Jan 2005 08:21:20 -0600,
> Mark_H_Johnson@raytheon.com wrote:
> > 
> > > At Tue, 4 Jan 2005 13:25:40 -0600,
> > > Mark_H_Johnson@raytheon.com wrote:
> > > > [snip - how to get to the problem]
> > > > At this point, I get the window asking if I heard the sound (I did
> > not). If
> > > > I repeat the test after waiting a short period, it eventually succeeds.
> > >
> > > The default blocking behavior of OSS devices was changed recently.
> > > When the device is in use, open returns -EBUSY immediately in the
> > > latest version while it was blocked until released in the former
> > > version.
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old applications)?
> 
> It was discussed on alsa-devel in November.  Unfortunately, I can't
> find ML archive any longer...
> 

Heh, if you want the excruciating details, here are some pointers.  It's
a long thread, and unfortunately the threading is a little broken.

Here's a link to the technical part:

http://sourceforge.net/mailarchive/message.php?msg_id=10008900

And here's the rant that started it:

http://sourceforge.net/mailarchive/message.php?msg_id=10014826

Lee

