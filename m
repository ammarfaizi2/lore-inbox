Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWJDA16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWJDA16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWJDA16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:27:58 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:48727 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030524AbWJDA15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:27:57 -0400
Message-ID: <BAYC1-PASMTP05E05E66F27DC4E0CC925FAE1D0@CEZ.ICE>
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Tue, 3 Oct 2006 20:27:54 -0400
From: Sean <seanlkml@sympatico.ca>
To: jt@hpl.hp.com
Cc: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-Id: <20061003202754.ce69f03a.seanlkml@sympatico.ca>
In-Reply-To: <20061003233138.GA2095@bougret.hpl.hp.com>
References: <1159807483.4067.150.camel@mindpipe>
	<20061003123835.GA23912@tuxdriver.com>
	<1159890876.20801.65.camel@mindpipe>
	<Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	<20061003180543.GD23912@tuxdriver.com>
	<4522A9BE.9000805@garzik.org>
	<20061003183849.GA17635@bougret.hpl.hp.com>
	<4522B311.7070905@garzik.org>
	<20061003214038.GE23912@tuxdriver.com>
	<20061003231648.GB26351@thunk.org>
	<20061003233138.GA2095@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2006 00:27:56.0337 (UTC) FILETIME=[F018FA10:01C6E74B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 16:31:38 -0700
Jean Tourrilhes <jt@hpl.hp.com> wrote:

> 	It's already done with the current interface, you can access
> the API with either ioctls or RtNetlink.

Does this answer Ted's question though?  Why can't userspace request
the new v48 interface to get the changed API while older tools
get the v47 interface and continue to work without needing to
be upgraded?

Sean
