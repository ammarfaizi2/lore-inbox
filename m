Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVCAOOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVCAOOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCAOOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:14:47 -0500
Received: from [195.23.16.24] ([195.23.16.24]:23986 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261917AbVCAONe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:13:34 -0500
Message-ID: <42247822.7030107@grupopie.com>
Date: Tue, 01 Mar 2005 14:11:46 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Bill Davidsen <davidsen@tmr.com>, Gerd Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <20050228134410.GA7499@bytesex><20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu> <4223A5C3.6010000@tmr.com> <42241491.2060303@andrew.cmu.edu>
In-Reply-To: <42241491.2060303@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> [...]
> The card= option didn't help in my case since my card is not in the 
> list; For thess cards we went off the reccomendation of other people 
> doing machine vision in Linux; Next time I guess we'll go name brand 
> again...

I think you should try it anyway, using all the options, because it is 
very likely that your card might be compatible with one of the listed 
ones. This is specially true if you don't care about the tuner.

Just modprobe the bttv module with card=X option, test it, rmmod it, 
modprobe it again with card=X+1, etc., until you find a number that fits.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
