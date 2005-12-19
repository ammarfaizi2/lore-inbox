Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVLSQDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVLSQDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLSQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:03:04 -0500
Received: from mail.gmx.net ([213.165.64.21]:16349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964787AbVLSQDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:03:01 -0500
X-Authenticated: #4399952
Date: Mon, 19 Dec 2005 17:03:00 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 build error
Message-ID: <20051219170300.165da3c3@mango.fruits.de>
In-Reply-To: <1135007186.16112.36.camel@mindpipe>
References: <20051218210614.75f424eb@mango.fruits.de>
	<43A5DBF0.6030801@cybsft.com>
	<20051219154410.4942e826@mango.fruits.de>
	<20051219162624.6a7f63b5@mango.fruits.de>
	<1135007186.16112.36.camel@mindpipe>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005 10:46:26 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> > But it doesn't run so well. Dmesg contains a BUG and an OOPS:
> > 
> 
> How about with high res timers disabled?

Good idea judging from the dmesg output alone. Interesting enough
though:

# CONFIG_HIGH_RES_TIMERS is not set

Hrmm. I'll rebuild. This time without -j3 and with make mrproper
beforehand.

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
