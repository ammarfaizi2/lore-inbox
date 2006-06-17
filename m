Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWFQOZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWFQOZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWFQOZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 10:25:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57817 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751624AbWFQOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 10:25:38 -0400
Subject: Re: UDF filesystem has some bugs on truncating
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <045101c69108$4992a130$106215ac@realtek.com.tw>
References: <045101c69108$4992a130$106215ac@realtek.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Jun 2006 15:42:08 +0100
Message-Id: <1150555328.10040.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-16 am 13:47 +0800, ysgrifennodd colin:
> Hi all,
> I found that UDF has bugs on truncating.
> When you do this:
>     dd if=/dev/zero of=aaa bs=1024k count=2 seek=3000
> , Linux will hang and die.

I'm unable to duplicate this on x86-64, do you have more information, eg
backtraces ?

