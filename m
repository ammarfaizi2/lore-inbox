Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030714AbWJDCWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030714AbWJDCWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbWJDCWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:22:45 -0400
Received: from mail2.genealogia.fi ([194.100.116.229]:385 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1030714AbWJDCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:22:44 -0400
Date: Tue, 3 Oct 2006 19:21:00 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004022100.GC6110@jm.kir.nu>
Mail-Followup-To: Jean Tourrilhes <jt@hpl.hp.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Norbert Preining <preining@logic.at>, hostap@shmoo.com,
	ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net
References: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <d120d5000610031208i4a204b2es8de8d424a573acf4@mail.gmail.com> <20061003194957.GB17855@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003194957.GB17855@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 12:49:57PM -0700, Jean Tourrilhes wrote:

> 	No, it's not. But as soon as *some part* of WE-21 appears in
> the kernel, the userspace expect the ESSID change. If we want to have
> WE-21 without the ESSID change, we need to fix userspace.

Or leave WIRELESS_EXT at 20 and come up with a new way of versioning any
future changes in WE.. Yes, having two different mechanisms for version
number is ugly, but it could prevent userspace breakage.

(And based on the other messages in this thread, it might be useful to
include the userspace program's idea of the version in those new
commands to allow multiple interface versions to be supported by the
kernel).

-- 
Jouni Malinen                                            PGP id EFC895FA
