Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWGSJym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWGSJym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWGSJyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:54:41 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:5520 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S964780AbWGSJyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:54:41 -0400
Message-ID: <44BE015E.5080107@mauve.plus.com>
Date: Wed, 19 Jul 2006 10:54:38 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Per-user swap devices.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop. It does not have enough RAM.
Due to the fact that the local hard disk is quite slow seeking - I've 
experimented with swap over wifi to a servers ramdisk - which lets me 
run more stuff till it slows down.
This works very well until there is a wifi problem - at which time 
everything dies.

While there are partial 'solutions' in some cases - lock stuff in RAM, 
... I was wondering about a more general solution.

It would be really nice to be able to simply: chown crashalot.users 
/dev/swap0 ;swapon /dev/swap0
Then anything run by crashalot would swap to /dev/swap0 - and not locally.
If it crashes, then firefox/whatever else bloated that they were running 
simply dies.

I assume this is not currently possible.
How much work would it be to get it to be so?
