Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUIAKmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUIAKmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUIAKmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:42:15 -0400
Received: from dev.tequila.jp ([128.121.50.153]:40209 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S266014AbUIAKmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:42:10 -0400
Message-ID: <4135A771.4050604@tequila.co.jp>
Date: Wed, 01 Sep 2004 19:41:53 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.6.8.1-mm4 and usb
References: <mailman.1093944725.30419.linux-kernel2news@redhat.com> <20040831232628.39dae8a3@lembas.zaitcev.lan>
In-Reply-To: <20040831232628.39dae8a3@lembas.zaitcev.lan>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> 
> This oops is very mysterious, because it indicates that sc->intf was
> NULL, which is not possible when device_remove_file was called.
> 
> I'll look at it. For the moment, just make sure you have this:

I can confirm that this patch fixes the problem of the oops during 
unmount/shutdown (or reboot). Thanks.

lg, clemens
