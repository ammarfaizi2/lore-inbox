Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUAJSEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAJSEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:04:05 -0500
Received: from ns.clanhk.org ([69.93.101.154]:57222 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265314AbUAJSD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:03:58 -0500
Message-ID: <3FFFE8E4.8080004@clanhk.org>
Date: Sat, 10 Jan 2004 11:58:28 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q re /proc/bus/i2c
References: <200401100117.42252.gene.heskett@verizon.net> <3FFF59A0.2080503@clanhk.org> <200401100754.47752.gene.heskett@verizon.net>
In-Reply-To: <200401100754.47752.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Friday 09 January 2004 20:47, J. Ryan Earl wrote:
>  
>
>I've also got a bttv card, whose init seems to be done quite early in 
>the bootup, and that requires I have i2c-dev in the kernel.  So I 
>might as well put it all in, the current situation.  All in, or all 
>out, it doesn't work.  A run of sensors right now, returns this:
>  
>

A couple questions:

1) Have you installed the lm-sensors package?
2) What kernel version?

Even with 2.6, you need to install the lm-sensors package, but not the 
i2c package as the kernel already has everything needed in it.  The 
lm-sensors packages contains drivers for all the sensor chips.  After 
you get lm-sensors installed on your current kernel, run sensors-detect 
to get the proper modules loaded for your hardware.

-ryan

