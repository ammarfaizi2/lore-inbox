Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTJRXlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJRXlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:41:04 -0400
Received: from main.gmane.org ([80.91.224.249]:58534 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261901AbTJRXlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:41:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Promise PDC20269 - PIO Only?
Date: Sun, 19 Oct 2003 01:40:59 +0200
Message-ID: <yw1x1xtai06s.fsf@users.sourceforge.net>
References: <200310181616.31093.jeremyhu@uclink4.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:wnV7ihxNjgXpIivVgMqh4nDa8WE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu> writes:

> I've been using two Promise PDC20269 cards for almost a year now in
> my system.  The cards are U133, but when the kernel boots up, I see
> the message that all the drives are operating in pio mode.  All the
> drives are U133 drives, and they are shown as operating in DMA mode
> when I put them on another controller.

I've got a PDC20268.  My boot messages also say PIO.  However, it
still uses DMA by default.  Check with "hdparm /dev/hdX" whether
your disks use DMA.

-- 
Måns Rullgård
mru@users.sf.net

