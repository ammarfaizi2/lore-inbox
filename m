Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266628AbUAWVFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266637AbUAWVFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:05:09 -0500
Received: from gprs146-184.eurotel.cz ([160.218.146.184]:26752 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266628AbUAWVFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:05:03 -0500
Date: Fri, 23 Jan 2004 22:04:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040123210449.GA250@elf.ucw.cz>
References: <20040123185914.GA870@elf.ucw.cz> <Pine.LNX.4.44.0401231402580.22566-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401231402580.22566-100000@chimarrao.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm afraid it needs to be more aggressive.
> 
> OK, is the patch below any better ?

Yes, this one actually works. When I launched two 150MB tasks, one of
them with ulimit -m 1, the limited task yielded its memory to
unlimited one. It worked as expected.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
