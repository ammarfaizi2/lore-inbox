Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbWJCVtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbWJCVtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbWJCVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:49:02 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38019 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030573AbWJCVs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:48:59 -0400
Message-ID: <4522DA9B.6050207@garzik.org>
Date: Tue, 03 Oct 2006 17:48:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: jt@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com>
In-Reply-To: <20061003214038.GE23912@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Unfortunately, I don't see any way to "fix" WE-21 without similarly
> breaking wireless-tools 29 and other "WE-21 aware" apps.  And since
> I'll bet that the various WE-aware apps have checks like "if WE >
> 20" for managing ESSID length settings, we may have painted ourselves
> into a korner (sic).

The apps are based on a pre-release kernel, which everyone knows could 
change, precisely for reasons like this.  Sounds like somebody took a 
risk, and lost...

	Jeff


