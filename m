Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUCKUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCKUJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:09:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:7376 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261689AbUCKUJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:09:53 -0500
Message-ID: <4050C780.7030504@colorfullife.com>
Date: Thu, 11 Mar 2004 21:09:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>at the previous try, with slab debugging enabled, it was spawning tons
>of errors but I suspect it's a bug in the slab debugging, it was
>complaining with red zone memory corruption, could be due the tiny size
>of this object (only 8 bytes).
>
>andrea@xeon:~> grep anon_vma /proc/slabinfo
>anon_vma            1230   1500     12  250    1 : tunables  120   60 8 : slabdata      6      6      0
>
According to the slabinfo line, 12 bytes. The revoke_table is 12 bytes, 
too, and I'm not aware of any problems with slab debugging enabled.

Could you send me the first few errors?

--
    Manfred

