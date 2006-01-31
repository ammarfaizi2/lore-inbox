Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWAaWaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWAaWaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWAaWaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:30:23 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:61571 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751692AbWAaWaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:30:22 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT] finally solve "swsusp fails with mysqld" problem
Date: Tue, 31 Jan 2006 23:30:50 +0100
User-Agent: KMail/1.9.1
Cc: seife@suse.de, Nigel Cunningham <nigel@suspend2.net>,
       linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601311717.56918.rjw@sisk.pl> <20060131212953.GA2018@elf.ucw.cz>
In-Reply-To: <20060131212953.GA2018@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601312330.50916.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 31 January 2006 22:29, Pavel Machek wrote:
> > > Place refrigerator hook at more clever place; avoids "system can't be
> > > suspended while mysqld running" problem.
> > > 
> > > I'd like you to test it. It looks correct to me, and it is actually a
> > > solution, not a workaround like my previous tries. It still does not
> > > solve suspend while running stress tests.
> > 
> > Which kernel is it against?  It does not apply to the recent -mm ...
> 
> Against vanilla -- but it should be easy to make it work against -mm.

Yes, I've already done it.

BTW, the no_signal labels are no longer needed in signal.c for i386 and
x86_64.

Greetings,
Rafael
