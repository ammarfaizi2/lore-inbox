Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWAHSoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWAHSoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbWAHSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:44:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6322 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932750AbWAHSoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:44:01 -0500
Subject: Re: [PATCH]: How to be a kernel driver maintainer
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1136744870.1043.4.camel@grayson>
References: <1136736455.24378.3.camel@grayson>
	 <1136737997.2955.10.camel@laptopd505.fenrus.org>
	 <1136744870.1043.4.camel@grayson>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 19:43:58 +0100
Message-Id: <1136745838.2955.17.camel@laptopd505.fenrus.org>
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


> But this isn't at al true. Almost all subsystems maintain the primary
> tree outside of the kernel, with the kernel being the primary _stable_
> tree. USB, Netdev,

patches yes. but usually only small stuff

>  Alsa, etc. All changes go someplace else before being
> pushed to the primary kernel tree. 99% of the time, patches are going
> somewhere else before going into the main kernel. 

that's different... that's a patch queue. That's not the same as being
the prime repository.

> So the above
> paragraphs is really misleading.

I guess neither is good then. I certainly would absolutely not want to
encourage developers to have a main "real driver" outside the kernel
source. Linus calls that "the cvs mentality" and time after time that
has proven to be really bad. You mention alsa, and to some degree alsa
is suffering from this ;(
(this is different from net/usb/scsi where changes are queued but merged
regularly and near immediately in case of bugfixes, unlike things like
alsa and firewire where basically the only choice is "all or nothing"
where "all" is bugfixes and new bugs)

