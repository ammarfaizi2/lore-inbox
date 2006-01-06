Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWAFRh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWAFRh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWAFRh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:37:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2748 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964806AbWAFRhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:37:55 -0500
Subject: Re: High load
From: Arjan van de Ven <arjan@infradead.org>
To: Aniruddh Singh <aps@jobsahead.com>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <1136562410.5557.4.camel@aps.monsterindia.noida>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
	 <1136550971.5557.2.camel@aps.monsterindia.noida>
	 <1136552226.2940.35.camel@laptopd505.fenrus.org>
	 <1136562410.5557.4.camel@aps.monsterindia.noida>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 18:37:52 +0100
Message-Id: <1136569073.2940.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 21:16 +0530, Aniruddh Singh wrote:
> On Fri, 2006-01-06 at 13:57 +0100, Arjan van de Ven wrote:
> > On Fri, 2006-01-06 at 18:06 +0530, Aniruddh Singh wrote:
> > > Hi,
> > > 
> > > there is a raid 0 and raid controller is Smart Array 64xx (rev 01)
> > > 
> > > hdparm -tT /dev/cciss/c0d0p2 returns the following
> > 
> > for measuring IO performance, I'd recommend tiobench over hdparm any day
> > ( http://tiobench.sf.net )
> 
> i will do it, can you please tell me why load goes high when i compile
> kernel (10 and above)

thats really odd, unless you do a "make -j", in which case of course
it's expected ;)


