Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270688AbTHJVQy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270691AbTHJVQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:16:54 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:49350 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270688AbTHJVQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:16:51 -0400
Message-ID: <3F36B703.90405@wanadoo.fr>
Date: Sun, 10 Aug 2003 23:20:03 +0200
From: =?ISO-8859-1?Q?R=E9mi_Colinet?= <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 : size of /proc/kcore is different from RAM size.
References: <3F36A74B.6090200@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rémi Colinet wrote:

> Hi,
>
> I have noticed that the /proc/kcore file has a different size (1Go) 
> compared with the available memory of my box (640Mo).
>
> [root@tigre01 kernel]# dmesg | grep Memory
> Memory: 643148k/655360k available (2331k kernel code, 11424k reserved, 
> 730k data, 348k init, 0k highmem)
>
> [root@tigre01 proc]# ls -l /proc | grep kcore
> -r--------    1 root     root     1073692672 Aug 10 21:43 kcore
> [root@tigre01 proc]#
>
> Is it a bug or just a new behaviour of the /proc/kcore?
>
> Regards,
> Rémi 

It's ok with 2.6.0-test3-mm1.

Remi





