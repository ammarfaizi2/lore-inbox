Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWHBSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWHBSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWHBSC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:02:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932118AbWHBSC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:02:27 -0400
Subject: Re: 2.6.18-rc1-mm2 and 2.6.18-rc3 (bttv: NULL pointer derefernce)
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.64.0608020957220.4168@g5.osdl.org>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <200607141830.01858.dominik.karall@gmx.net>
	 <200608021800.23905.dominik.karall@gmx.net>
	 <20060802094904.2057eaf4.akpm@osdl.org>
	 <Pine.LNX.4.64.0608020957220.4168@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 02 Aug 2006 15:02:05 -0300
Message-Id: <1154541726.9413.6.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Em Qua, 2006-08-02 às 09:57 -0700, Linus Torvalds escreveu:
> 
> On Wed, 2 Aug 2006, Andrew Morton wrote:
> > 
> > I believe this is fixed in Mauro's not-yet-pulled DVB tree?
> 
> Well, the DVB tree isn't _getting_ pulled, since it exploded in size after 
> -rc1, and as such is not pullable any more.

As I said on my previous email, "master" branch have just a few small
fixing patches (26 patches, changing 39 files). We have several
improvements to 2.6.19 on "devel" branch. I suspect you've pulled the
wrong branch. At the time you tried to pull, "devel" were marked as the
current branch. Please re-check.

$ git checkout -f master
$ git diff origin |diffstat | grep changed

 39 files changed, 354 insertions(+), 143 deletions(-)

> 
> 		Linus
Cheers, 
Mauro.

