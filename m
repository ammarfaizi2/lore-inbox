Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKWUvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKWUvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKWUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:50:57 -0500
Received: from pv106075.reshsg.uci.edu ([128.195.106.75]:49544 "EHLO
	alpha.blx4.net") by vger.kernel.org with ESMTP id S261600AbUKWUs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:48:56 -0500
Message-ID: <41A3A238.3070003@blx4.net>
Date: Tue, 23 Nov 2004 12:48:56 -0800
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT610 IDE support for 2.4.28 (trivial)
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com>
In-Reply-To: <41A38128.90305@pobox.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Mathias Kretschmer wrote:
>
>> hi,
>>
>> I found an older version of this patch (against 2.4.22) on some 
>> website. After a little bit of editing it applied cleanly to 2.4.27 
>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 
>> 4x 300GB disks.
>>
>> Maybe someone finds this patch helpful. Any reason why the original 
>> patch did not make it into the kernel ?
>
>
> Why not add it to the existing via82cxxx driver, and get better 
> performance and device tuning?


I only have that one ASUS board and there's data on the disks that I do 
not want to loose.
The current patch worked well for me (performance is pretty decent), so 
I went with it.

I can modify the VIA driver code, but looking at the various 
exceptions/quirks for the various VIA chip sets, I'm a bit hesitant to 
test it on my box.

-Mathias

