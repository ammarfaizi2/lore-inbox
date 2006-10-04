Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030706AbWJDCMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030706AbWJDCMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 22:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030707AbWJDCMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 22:12:44 -0400
Received: from mail2.genealogia.fi ([194.100.116.229]:41856 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1030706AbWJDCMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 22:12:43 -0400
Date: Tue, 3 Oct 2006 19:10:20 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Jeff Garzik <jeff@garzik.org>, "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004021020.GB6110@jm.kir.nu>
Mail-Followup-To: Jean Tourrilhes <jt@hpl.hp.com>,
	Jeff Garzik <jeff@garzik.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Norbert Preining <preining@logic.at>, hostap@shmoo.com,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net
References: <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <4522DA9B.6050207@garzik.org> <20061003222707.GB1790@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003222707.GB1790@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 03:27:07PM -0700, Jean Tourrilhes wrote:

> 	Let's not make a mountain of this molehill. If you want to use
> old versions of Wireless Tools and wpa_supplicant with WE-21, what you
> need is just to add a dummy character at the end of your ESSID. And
> everything will be fine.

Nope, everything won't be fine with WPA-PSK which is using SSID as part
of the key derivation. In other words, you cannot add a dummy character
in the end of the SSID in wpa_supplicant configuration for a WPA-PSK
network and expect everything to work.

-- 
Jouni Malinen                                            PGP id EFC895FA
