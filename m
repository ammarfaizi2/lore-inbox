Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWGVQmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWGVQmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGVQmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:42:22 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:27022
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750878AbWGVQmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:42:21 -0400
Message-ID: <44C25548.5070307@microgate.com>
Date: Sat, 22 Jul 2006 11:41:44 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>
Subject: Re: Success: tty_io flush_to_ldisc() error message triggered
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com>
In-Reply-To: <200607221209_MC3-1-C5CA-50EB@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> The cleaner fix looks more intrusive, though.
> 
> Is this simpler change (what I'm running but without the warning
> messages) the preferred fix for -stable?

It fixes the problem.

The ugly thing about that patch is adding
another TTY_XXX macro that is not really necessary.
I created it as a quick and dirty way of testing
my hypothesis about the problem.

I don't see a problem using it as a simple
(albeit naive) approach to fix stable.

--
Paul Fulghum
Microgate Systems, Ltd
