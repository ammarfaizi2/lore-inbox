Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVAPE4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVAPE4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVAPE4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:56:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:2225 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262428AbVAPE4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:56:53 -0500
Message-ID: <41E9F25D.5050906@osdl.org>
Date: Sat, 15 Jan 2005 20:49:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kaos@sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: conglomerate objects in reference*.pl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

I'm seeing some drivers/*/built-in.o that should be ignored AFAIK,
but they are not ignored.  Any ideas?

This is 2.6.11-rc1-bk3 on i386 with allmodconfig
(except DEBUG_INFO=n) and gcc 3.3.3.

Error: ./drivers/ide/built-in.o .text refers to 00000939 R_386_PC32 
      .init.text
Error: ./drivers/ide/legacy/built-in.o .text refers to 00000939 
R_386_PC32        .init.text
Error: ./drivers/ide/legacy/hd.o .text refers to 00000939 R_386_PC32 
       .init.text

Thanks,
-- 
~Randy
