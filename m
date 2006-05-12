Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWELKgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWELKgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWELKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:36:49 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:37072
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751163AbWELKgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:36:48 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Linux v2.6.17-rc4
Date: Fri, 12 May 2006 12:44:22 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <20060512102422.GA30285@harddisk-recovery.com>
In-Reply-To: <20060512102422.GA30285@harddisk-recovery.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121244.22511.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 12:24, you wrote:
> On Thu, May 11, 2006 at 04:44:03PM -0700, Linus Torvalds wrote:
> > Ok, I've let the release time between -rc's slide a bit too much again, 
> > but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> > 
> > If you know of any regressions, please holler now, so that we don't miss 
> > them. 
> 
> I got assertion failures in the bcm43xx driver:
> 
> bcm43xx: Chip ID 0x4318, rev 0x2

That is expected an non-fatal.
It is no regression.

We are working on it, but there won't be any fix for 2.6.17, as
very intrusive changes are needed to fix this.

-- 
Greetings Michael.
