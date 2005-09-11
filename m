Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVIKXJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVIKXJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVIKXJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:09:37 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:52091 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751021AbVIKXJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:09:36 -0400
Message-ID: <4324B929.7090001@bigpond.net.au>
Date: Mon, 12 Sep 2005 09:09:29 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michal.k.k.piotrowski@gmail.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: oops plugsched, spa_ws, scsi, sata, ata_piix, threading 2.6.13-mm2
References: <4323896F.5050703@bigpond.net.au> <6bffcb0e05091113576925a8e9@mail.gmail.com>
In-Reply-To: <6bffcb0e05091113576925a8e9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 11 Sep 2005 23:09:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> [1.] One line summary of the problem:
> Oops when starting system.
> 
> [2.] Full description of the problem/report:
> Kernel boot params:
> kernel /vmlinuz-2.6.13-mm2 root=/dev/sda1 ro cpusched=spa_ws

Could you please confirm that this only occurs with cpusched=spa_ws and 
not with any of the other schedulers?  In particular, if you could try 
it for ingosched, staircase and spa_no_frills I would appreciate it.

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
