Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUIWWvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUIWWvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUIWWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:47:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5892 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267478AbUIWWpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:45:22 -0400
In-Reply-To: <415339D3.2080206@skynet.be>
References: <4151E749.7060107@skynet.be> <47612A96-0CDB-11D9-BC62-000D9352858E@linuxmail.org> <415339D3.2080206@skynet.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3E89F45D-0DB2-11D9-BBF4-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.x ( unable to open an initial console & unable to mount devfs, err: -5 )
Date: Fri, 24 Sep 2004 00:45:18 +0200
To: Madnux <madnux@skynet.be>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23, 2004, at 23:02, Madnux wrote:

> Sorry but i'm not running udev !

That's the problem... FC3T2 is supposed to use udev.
>
> I've run /sbin/MAKEDEV but it doesn't work anymore.

How? What commands did you run?
>
> I still get "Unable to open an initial console"

Please, check if /dev/console exists. I guess this special chardev is 
missing.

