Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWHPSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHPSop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWHPSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:44:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10694 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750732AbWHPSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:44:44 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Arjan van de Ven <arjan@infradead.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060816183707.GD13641@csclub.uwaterloo.ca>
References: <44E3552A.6010705@gmx.net>
	 <20060816183707.GD13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 16 Aug 2006 20:44:19 +0200
Message-Id: <1155753859.3023.127.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 14:37 -0400, Lennart Sorensen wrote:
> On Wed, Aug 16, 2006 at 07:26:02PM +0200, Dirk wrote:
> > I have changed a message that didn't clearly tell the user what was goin
> > on...
> > 
> > Please have a look!
> 
> Perhaps the real problem is that some @#$@#$ user space task is
> constantly trying to mount the disc while something else is trying to
> write to it.
> 
> gnome and kde both seem very eager to implement such things.  perhaps
> there should be a way to prevent any access by such processes while
> writing to the disc.

there is. O_EXCL works for this.
Any sane desktop app and cd burning app use O_EXCL already for this
purpose...


