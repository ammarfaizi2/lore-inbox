Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752118AbWJNI1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWJNI1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 04:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWJNI1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 04:27:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24493 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752118AbWJNI1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 04:27:04 -0400
Date: Sat, 14 Oct 2006 10:26:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Burman Yan <yan_952@hotmail.com>
Cc: kronos.it@gmail.com, linux-kernel@vger.kernel.org
Subject: HP disk protection Re: Remn Yan <yan_952@hotmail.com> ha scritto:
Message-ID: <20061014082608.GA3851@elf.ucw.cz>
References: <20061013165840.GA9517@dreamland.darkstar.lan> <BAY20-F2590BB342DED17F10A6783D80A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F2590BB342DED17F10A6783D80A0@phx.gbl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-10-13 20:32:48, Burman Yan wrote:
> >From: Luca Tettamanti <kronos.it@gmail.com>

> >Burman Yan <yan_952@hotmail.com> ha scritto:
> >> I would like to hear your remarks on this version.
> >
> >> +static ssize_t mdps_calibrate_store(struct device *dev,
> >> +                   struct device_attribute *attr, const char *buf, 
> >size_t count)
> >> +{
> >> +	mdps_calibrate_mouse();
> >> +	return count;
> >> +}
> >
> >No locking here?
> 
> I don't want to lock it here, since the mouse polling kthread is heavy as 
> it is.

> I'd rather report a wrong value of mouse position while recalibrating.
> The way I see it, if you're recalibrating your mouse, chances are you're 
> not playing at the same precise millisecond. In my opinion it's worth more 
> battery life.

Hmm, and are you sure it can't oops or something?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
