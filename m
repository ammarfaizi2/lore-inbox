Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVBKMJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVBKMJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 07:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBKMJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 07:09:52 -0500
Received: from B3114.karlshof.wh.tu-darmstadt.de ([130.83.219.14]:30366 "HELO
	B3114.karlshof.wh.tu-darmstadt.de") by vger.kernel.org with SMTP
	id S262125AbVBKMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 07:09:50 -0500
Subject: Re: [linux-dvb-maintainer] DVB at76c651.c driver seems to be dead
	code
From: Andreas Oberritter <obi@linuxtv.org>
To: Holger Waechtler <holger@qanu.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Linux-dvb <Linux-dvb@linuxtv.org>
In-Reply-To: <420C7C83.4070309@qanu.de>
References: <20050210235605.GN2958@stusta.de>  <420C7C83.4070309@qanu.de>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 13:11:08 +0100
Message-Id: <1108123869.3535.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 10:36 +0100, Holger Waechtler wrote:
> Adrian Bunk wrote:
> 
> >I didn't find any way how the drivers/media/dvb/frontends/at76c651.c 
> >driver would do anything inside kernel 2.6.11-rc3-mm2. All it does is to 
> >EXPORT_SYMBOL a function at76c651_attach that isn't used anywhere.
> >
> >Is a patch to remove this driver OK or did I miss anything?
> >  
> >
> 
> no, please let it there. This driver is the GPL'd part of the dbox2 
> driver which is not part of the official kernel tree.

(Actually all dbox2 drivers are GPL-licensed, you can get them at
cvs.tuxbox.org)

> Since frontend and demod drivers are reusable elsewhere and mainstream 
> hardware that makes use of this demodulator may show up every week it's 
> just stupid to remove this code as long we know it is working and 
> continously tested by the dbox2 folks.
> 
> Instead it may make sense to move the dbox2 sources into the mainstream 
> source tree. Andreas, what do you think?

It has been a long term goal since months, but I don't have the time for
it now. We are still waiting for mpc8xx to become stable in 2.6.

Regards,
Andreas

