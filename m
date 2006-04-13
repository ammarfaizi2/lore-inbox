Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWDMOYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWDMOYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWDMOYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:24:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46026 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964946AbWDMOYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:24:07 -0400
Date: Thu, 13 Apr 2006 16:23:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Avramenko Andrew <liksx@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Troubles with booting init
In-Reply-To: <200604131147.05686.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0604131621570.17374@yvahk01.tjqt.qr>
References: <443E0DEC.4000602@mail.ru> <200604131147.05686.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've compiled kernel for it but it doesn't work. It doesn't shows any 
>> error but stopped with:
>
>I bet your /sbin/init (or all programs spawned by it)
>is compiled with P4 instructions (cmov or something like that).
>
>Recompile those for 386.

I can confirm that from a similar experience. Running a glibc-i586 on i386 
locks up too due to cmpxchg not being available.


Jan Engelhardt
-- 
