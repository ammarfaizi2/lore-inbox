Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTKYU0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTKYU0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:26:06 -0500
Received: from smtp02.web.de ([217.72.192.151]:35604 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263142AbTKYU0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:26:02 -0500
Subject: Re: 2.6.0-preX causes memory corruption
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069791966.2343.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 21:26:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After installing 2.6.0-pre9 the System seemed to work normally,
> > all the

> You mean 2.6.0-test9, don't you?

Yes

> > stuff I did before worked normally but when doing large
> > fileoperation including crunching stuff using bzip2 (e.g.
> > checking out modules from CVS and tar'ing them up) the
> > archives get corrupt. I was first assuming that this was
> > a onetime mistake and thus I deleted the corrupt file and
> > re-run my normal operations. But after a while I noticed
> > that this problem occoured more and more and I was starting
> > to worry. Archives are showing to be corrupted but after an
> > reset these archives can be unpacked normally again.

> Do you have preemptive kernel enabled (CONFIG_PREEMPT=y)?

Yes

> There's been some discussion about it possibly causing strange
> things in some configurations. If it helps to disable it, please
> post your .config, so we can compare with others.

Yes, saw it after I've posted my mail. But here is my config.

http://www.akcaagac.com/.config

Hope it helps.

