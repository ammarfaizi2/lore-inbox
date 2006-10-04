Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWJDAgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWJDAgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWJDAgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:36:49 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:16664 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161023AbWJDAgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:36:48 -0400
Message-ID: <BAYC1-PASMTP06428EB5C8F0E14C446BFFAE1D0@CEZ.ICE>
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Tue, 3 Oct 2006 20:36:46 -0400
From: Sean <seanlkml@sympatico.ca>
To: jt@hpl.hp.com
Cc: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-Id: <20061003203646.60d9589a.seanlkml@sympatico.ca>
In-Reply-To: <20061004003031.GA2215@bougret.hpl.hp.com>
References: <1159890876.20801.65.camel@mindpipe>
	<Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	<20061003180543.GD23912@tuxdriver.com>
	<4522A9BE.9000805@garzik.org>
	<20061003183849.GA17635@bougret.hpl.hp.com>
	<4522B311.7070905@garzik.org>
	<20061003214038.GE23912@tuxdriver.com>
	<20061003231648.GB26351@thunk.org>
	<20061003233138.GA2095@bougret.hpl.hp.com>
	<20061003202754.ce69f03a.seanlkml@sympatico.ca>
	<20061004003031.GA2215@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2006 00:39:49.0843 (UTC) FILETIME=[99615A30:01C6E74D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 17:30:31 -0700
Jean Tourrilhes <jt@hpl.hp.com> wrote:

> 	How does that happen in practice ? Kernel has no clue on what
> userpace version is running.
> 

Ted mentioned that the way it works for stat is that userspace requests
an API version and the kernel delivers it.  So old versions request old
API and new versions request new API.  You only ever _add_ new API, and
never remove older versions.

Sean
