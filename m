Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWAaVaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWAaVaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWAaVaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:30:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62890 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751506AbWAaVaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:30:06 -0500
Date: Tue, 31 Jan 2006 22:29:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: seife@suse.de, Nigel Cunningham <nigel@suspend2.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] finally solve "swsusp fails with mysqld" problem
Message-ID: <20060131212953.GA2018@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601310102.00646.rjw@sisk.pl> <20060131092726.GA2718@elf.ucw.cz> <200601311717.56918.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311717.56918.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Place refrigerator hook at more clever place; avoids "system can't be
> > suspended while mysqld running" problem.
> > 
> > I'd like you to test it. It looks correct to me, and it is actually a
> > solution, not a workaround like my previous tries. It still does not
> > solve suspend while running stress tests.
> 
> Which kernel is it against?  It does not apply to the recent -mm ...

Against vanilla -- but it should be easy to make it work against -mm.

								Pavel
-- 
Thanks, Sharp!
