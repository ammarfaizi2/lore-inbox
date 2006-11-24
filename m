Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757669AbWKXLE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbWKXLE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757672AbWKXLE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:04:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50089 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1757665AbWKXLE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:04:56 -0500
Date: Fri, 24 Nov 2006 12:04:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Siemens SX1: sound cleanups
Message-ID: <20061124110439.GC5608@elf.ucw.cz>
References: <20061119114938.GA22514@elf.ucw.cz> <1163971825.22176.91.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163971825.22176.91.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-11-19 16:30:25, Lee Revell wrote:
> On Sun, 2006-11-19 at 12:49 +0100, Pavel Machek wrote:
> > +int set_mixer_volume(int mixer_vol)
> >  {
> > -       int retVal;
> > +       /* FIXME: Alsa has mixer_vol in 0-100 range, while SX1 needs
> > 0-9 range */
> 
> Untrue.  ALSA uses whatever range you define in the info callback for
> the mixer element.  I guess it just defaults to 0-100 if you don't set
> it.

Thanks, fixed.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
