Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWGDK50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWGDK50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGDK50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:57:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32211 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932208AbWGDK5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:57:25 -0400
Date: Tue, 4 Jul 2006 12:57:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>,
       Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060704105711.GA13658@elf.ucw.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Just use input infrastructure and be done with that? You can do
> >parking from userspace.
> 
> Will moving the hdapsd userspace daemon from sysfs polling to the
> input infrastructure cause a noticable latency increase compared to
> polling sysfs? This functionality is highly time-critical.

Well, for input you should need no polling. input tells you when data
is ready.

> BTW, can the driver tell when nothing is accessing its input device,
> and avoid polling in that case?

Ask vojtech/dmitry, I guess.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
