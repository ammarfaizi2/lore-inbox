Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTIAXyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTIAXyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:54:24 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:41198 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S263354AbTIAXyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:54:23 -0400
Message-ID: <3F53DCBA.2080907@sixbit.org>
Date: Mon, 01 Sep 2003 19:56:42 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless driver
References: <r0Yy.Zd.7@gated-at.bofh.it> <r0YD.Zd.21@gated-at.bofh.it>
In-Reply-To: <r0YD.Zd.21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>My wireless card is not working in the new test4 kernel. It appears the
>>driver is broken and the card gets detected as a memory card and the
>>kernel module memory_cs tries to get loaded instead. Does anyone know
>>if there is a fix for this?
> 
> humm, I saw this lots of times, care to try, after it is detected as "memory"
> to do this:
> cardctl eject
> cardctl insert
> and see if gets correctly detected this turn? works for me.

I have an Orinoco wireless card, and it is functioning perfectly with 
2.6.0-test4 (without requiring the eject<->insert trick).  Which archs 
are affected by this?

