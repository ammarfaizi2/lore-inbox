Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVLHD3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVLHD3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 22:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbVLHD3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 22:29:47 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:19897 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030448AbVLHD3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 22:29:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Wed, 7 Dec 2005 22:29:42 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <d120d5000512060845l1d035f46ub8d9334b6936f9e7@mail.gmail.com> <20051207112909.GA4012@merlin.emma.line.org>
In-Reply-To: <20051207112909.GA4012@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512072229.42335.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 06:29, Matthias Andree wrote:
> On Tue, 06 Dec 2005, Dmitry Torokhov wrote:
> 
> > On 12/6/05, Matthias Andree <matthias.andree@gmx.de> wrote:
> > >
> > > QA has to happen at all levels if it is supposed to be affordable or
> > > scalable. The development process was scaled up, but QA wasn't.
> > >
> > > How about the Signed-off-by: lines? Those people who pass on the changes
> > > also pass on the bugs, and they are responsible for the code - not only
> > > license-wise, but also quality-wise. That's the latest point where
> > > regression tests MUST happen.
> > 
> > People who pass the changes can only test ones they have hardware for.
> > For the rest they can try to validate the code by reading patches but
> > have to rely on the submitter wrt to the patch actually working.
> 
> What I'm saying is that people (maintainer) should have a selected
> number of people (users) test the patches before they are merged.
> 

And we try. Take for example psmouse_resync patch that is now in -mm.
I got about 30 reports that it worked and fixed people's problems before
I got it to Andrew. And still as soon as it got to -mm I got a complaint
that it failed on one of boxes ;(

-- 
Dmitry
