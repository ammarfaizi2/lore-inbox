Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVAOAae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVAOAae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVAOAae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:30:34 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:40855 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262053AbVAOAa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:30:28 -0500
Message-ID: <41E882C8.9060208@gentoo.org>
Date: Sat, 15 Jan 2005 02:41:12 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andres Salomon <dilinger@voxel.net>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
References: <1105605448.7316.13.camel@localhost>	 <41E7F44C.5010702@bio.ifi.lmu.de>  <41E8565A.4050707@gentoo.org> <1105737963.7677.6.camel@localhost>
In-Reply-To: <1105737963.7677.6.camel@localhost>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres, Frank,

Andres Salomon wrote:
> 
> Odd.  I'll have to try Frank's .config and see if I can reproduce it (it
> doesn't happen w/ mine).

Here is the patch that fixes it for me:
	http://linux.bkbits.net:8080/linux-2.6/cset@1.2273.1.9
Needs to be applied alongside the rlimit and stack expansion fixes.

Andres, I have not tried the patch you suggested, since I found that the above 
one fixes it. However, judging by the description of the one you mailed me, I 
don't think it will make any difference (I do not use highmem).

Thanks,
Daniel
