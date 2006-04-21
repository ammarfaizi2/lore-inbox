Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWDURGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWDURGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDURGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:06:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64916 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751305AbWDURGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:06:12 -0400
Subject: Re: [PATCH] Rename "swapper" to "idle"
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Michael Buesch <mb@bu3sch.de>, mikado4vn@gmail.com,
       linux-kernel@vger.kernel.org, Hua Zhong <hzhong@gmail.com>
In-Reply-To: <Pine.LNX.4.61.0604211708300.31515@yvahk01.tjqt.qr>
References: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com>
	 <4448EEE7.5010708@gmail.com> <200604211656.50485.mb@bu3sch.de>
	 <Pine.LNX.4.61.0604211708300.31515@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 13:05:58 -0400
Message-Id: <1145639158.24962.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 17:08 +0200, Jan Engelhardt wrote:
> >> > Swapper does not do these things. It just happens to be "running" at that time (and it is always running if the system is idle).
> >> >
> >> > IOW, it is indeed an "idle" process. In fact, all it does is cpu_idle().
> >> 
> >> Really? Are your sure that swapper only does cpu_idle()???
> >
> >Yes.
> >Idle is by definition Nothing.
> >

> So call it "voidd" :>

That should be "kvoidd" :P

-- Steve


