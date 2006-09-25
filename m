Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWIYRQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWIYRQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWIYRQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:16:23 -0400
Received: from mail.aknet.ru ([82.179.72.26]:48901 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751309AbWIYRQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:16:22 -0400
Message-ID: <45180F36.8010908@aknet.ru>
Date: Mon, 25 Sep 2006 21:17:42 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <1159059219.3093.276.camel@laptopd505.fenrus.org>
In-Reply-To: <1159059219.3093.276.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan.

Arjan van de Ven wrote:
> ... to add a "security" feature?
> sounds like the wrong tradeoff!
There is now an ongoing discussion about that here:
http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0609.2/2151.html
continues here:
http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0609.3/0008.html
with many posts already.
I'd like you to contribute to it.

In particular, I would be very happy if you (or anyone
else) will tell me why the noexec filesystem deny PROT_EXEC
for MAP_PRIVATE, while even the R/O filesystem doesn't deny
PROT_WRITE for MAP_PRIVATE? This is one of the key points of
mine, but there are others too.

