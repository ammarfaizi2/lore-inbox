Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTLVXsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTLVXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:48:40 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:12496 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264588AbTLVXsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:48:39 -0500
Subject: Re: 2.6.0 modules don't link properly
From: Andre Tomt <lkml@tomt.net>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bs7u1f$8ns$1@gatekeeper.tmr.com>
References: <bs7u1f$8ns$1@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1072136923.1088.249.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 00:48:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 00:17, bill davidsen wrote:
> I tried building 2.6.0-final on a new whitebox-3.0-final install, and
> the modules_install produced thousands of unresolved symbols. This built
> on another machine I've been running and updating since the 2.5.3x days,
> so there might be something I've missed, but I don't quite see what it
> would be.
> 
> Whitebox is built from RH-ES-3.0 source, so the only things I updated
> were the procps and modutils, using the last tar which didn't have "pre"
> in the name. I see that there is a new tar, out nearly ten hours so it
> must be stable, which has jumped from 0.9.15 to 3.0.15-pre1, but I'm
> happily using something months old on other systems.
> 
> Can someone toss me a clue? Has anyone had a working build with
> RH-ES-3.0? Yes, I know other things need to be done before I can
> actually run the kernel, but being able to build would be nice, since I
> got a new test system just for 2.6 test/demo use.

Sounds like a case of missing module-init-tools.


