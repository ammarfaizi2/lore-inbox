Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWFBI7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWFBI7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBI7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:59:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751340AbWFBI7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:59:20 -0400
Date: Fri, 2 Jun 2006 10:58:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ondrej Zajicek <santiago@mail.cz>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       David Lang <dlang@digitalinsight.com>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060602085832.GA25806@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060602083604.GA2480@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 02-06-06 10:36:04, Ondrej Zajicek wrote:
> On Wed, May 31, 2006 at 05:53:09AM +0800, Antonino A. Daplas wrote:
> > David Lang wrote:
> > > On Sun, 28 May 2006, Jon Smirl wrote:
> > So even a dumb driver such as vesafb that has to do on the fly
> > color conversions while pushing 64x more data to the bus can be
> > faster than vgacon.
> 
> I just implemented text mode switch and tileblit ops into viafb
> (http://davesdomain.org.uk/viafb/index.php) and it is about four
> times faster than accelerated graphics mode and about eight times
> faster than unaccelerated graphics mode (both measured using cat
> largefile with ypan disabled). So textmode is meaningful
> alternative.

I mean.... it is displaying text faster than refresh rate... so who
cares?

You can only *display* so much text a second (and then, user is only
able to see *much* less text) and both text mode and frame buffers are
way past that limits. so.... who cares?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
