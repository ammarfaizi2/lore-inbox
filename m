Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUI2NSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUI2NSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUI2NSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:18:11 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:51027 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268413AbUI2NR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:17:29 -0400
Message-ID: <415AB5E1.8060406@microgate.com>
Date: Wed, 29 Sep 2004 08:17:21 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?Um9sYW5kIENhw59lYm9obQ==?= 
	<roland.cassebohm@VisionSystems.de>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial driver hangs
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <1096409562.14082.53.camel@localhost.localdomain> <1096420364.6003.29.camel@at2.pipehead.org> <200409291509.39187.roland.cassebohm@visionsystems.de>
In-Reply-To: <200409291509.39187.roland.cassebohm@visionsystems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Caßebohm wrote:
> I have made a little test, at which the receive interrupt is 
> disabled in that state. It seems to be no improvement to the 
> solution of just trow away the bytes of the FIFO. In both 
> cases characters got lost.

How did you reenable the receive interrupt in your test?

-- 
Paul Fulghum
paulkf@microgate.com
