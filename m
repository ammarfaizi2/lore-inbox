Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265463AbSJXOoq>; Thu, 24 Oct 2002 10:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbSJXOoq>; Thu, 24 Oct 2002 10:44:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31505 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265463AbSJXOop>;
	Thu, 24 Oct 2002 10:44:45 -0400
Message-ID: <3DB808C8.2000204@pobox.com>
Date: Thu, 24 Oct 2002 10:50:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doruk Fisek <dfisek@fisek.com.tr>
CC: linux-kernel@vger.kernel.org
Subject: Re: bcm5700
References: <20021024120604.1220fd46.dfisek@fisek.com.tr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doruk Fisek wrote:
> Hi,
> 
> Where can I get the latest kernel patch for BCM5700 ethernet adapter?
> 
> I have the BCM5700-2.2.8 patch for kernel 2.4.18 but I couldn't find one for
> 2.4.19 nor for the latest prereleases of 2.4.20.



To add to what David said, I would not advise using this driver.  It 
continues to have bugs (BroadCom is amusing enough to add new ones 
even), and doesn't support all the Linux kernel NIC driver standards.

"tg3" is the way to go :)

	Jeff



