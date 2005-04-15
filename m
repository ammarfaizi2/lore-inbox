Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVDOJgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVDOJgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDOJgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 05:36:45 -0400
Received: from sophia.inria.fr ([138.96.64.20]:12430 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S261774AbVDOJgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 05:36:43 -0400
Message-ID: <425F8B09.3010706@yahoo.fr>
Date: Fri, 15 Apr 2005 11:36:09 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: snd-ens1371 (alsa) & joystick woes
References: <425BACC2.9020709@yahoo.fr>
In-Reply-To: <425BACC2.9020709@yahoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (sophia.inria.fr [138.96.64.20]); Fri, 15 Apr 2005 11:36:09 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain wrote:

> From 2.6.11 to 2.6.12-rc2, there are some changes in the joystick 
> behaviour
> that I don't think are expected. It's a simple joystick using 
> analog.ko plugged
> on a sound board using snd-ens1371. So here we go:

Reverting 
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/input/joydev.c@1.31?nav=index.html|src/|src/drivers|src/drivers/input|hist/drivers/input/joydev.c
(removing all the added " + 1" in joydev.c) fixes it for me.

Regards.

-- 
Guillaume

