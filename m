Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVC2LVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVC2LVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVC2LVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:21:34 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:8404 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262183AbVC2LV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:21:29 -0500
Message-ID: <42493B9C.128EC84A@tv-sign.ru>
Date: Tue, 29 Mar 2005 15:27:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH rc1-mm3] timers: simplify locking
References: <424835D5.99FDB1D5@tv-sign.ru> <Pine.LNX.4.58.0503281206390.27734@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> Ok. Testing with your latest and greatest patches.

Many thanks.

> Is there any clarity about what caused the hangs?

No, I still hope these hangs are unrelated to these patches.
I am trying to find the bug, but I can't. May be it is because
I do not want to believe that these patches are buggy :)

I tried to stress them with various small tests I wrote and I
have not found any problems.

And I don't know what kernel you are using, there is additional
timer patch in mm2.

Oleg.
