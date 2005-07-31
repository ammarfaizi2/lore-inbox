Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVGaSmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVGaSmC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGaSmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:42:02 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:55049 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261869AbVGaSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:42:01 -0400
Message-ID: <42ED1B6F.9090005@roarinelk.homelinux.net>
Date: Sun, 31 Jul 2005 20:41:51 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net> <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

 >
 >  - The SonyPI driver just allocates IO regions in random areas. It's got a
 >    list of places to try allocating in, and the 1080 area just happens to
 >    be the first on the list, and since it's not used by anything else, it
 >    succeeds (never mind that it's on totally the wrong bus).

On three different intel-vaios, I've seen the sonypi device always
located at ioport 0x1080. Even the windows driver on these models
always allocates the 0x1080-0x109f io-range for it.

-- 
  Manuel Lauss

