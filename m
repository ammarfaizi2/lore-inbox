Return-Path: <linux-kernel-owner+w=401wt.eu-S1752100AbWLXPDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWLXPDv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 10:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWLXPDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 10:03:51 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:53111 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbWLXPDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 10:03:50 -0500
X-Greylist: delayed 1424 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 10:03:50 EST
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in
	2.6.20-rc1)
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
In-Reply-To: <20061223235501.GA1740@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
	 <20061223235501.GA1740@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 24 Dec 2006 15:39:23 +0100
Message-Id: <1166971163.15485.21.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > I got this nasty oops while playing with debugger. Not sure if that is
> > related; it also might be something with bluetooth; I already know it
> > corrupts memory during suspend, perhaps it corrupts memory in some
> > error path?
> 
> Okay, I spoke too soon. bluetooth & suspend memory corruption was
> _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> cycles... so it is probably unrelated to the previous crash.

can you try to reproduce this with 2.6.20-rc2 as well.

Regards

Marcel


