Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbTDBSmc>; Wed, 2 Apr 2003 13:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbTDBSmc>; Wed, 2 Apr 2003 13:42:32 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:64786 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S263098AbTDBSmc>; Wed, 2 Apr 2003 13:42:32 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200304021846.h32Ikf310399@mako.theneteffect.com>
Subject: Re: subsystem crashes reboot system?
To: freesoftwaredeveloper@web.de (Michael Buesch)
Date: Wed, 2 Apr 2003 12:46:41 -0600 (CST)
Cc: rmiller@duskglow.com (Russell Miller), linux-kernel@vger.kernel.org
In-Reply-To: <200304022044.27530.freesoftwaredeveloper@web.de> from "Michael Buesch" at Apr 02, 2003 08:44:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Isn't this what watchdog is for?  I think even the software watchdog would
> > catch this, then you can panic and reboot.
> 
> hm, I don't think, that watchdog will catch this, because the userspace-watchdog
> daemon will still be running properly in a crash case
> (or did I understand something wrong?)

But it wouldn't be able to write to the filesystem so it would trigger
if I believe.

	M
