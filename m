Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVJaQuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVJaQuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVJaQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:50:04 -0500
Received: from mail.ncipher.com ([82.108.130.24]:15238 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S932458AbVJaQuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:50:02 -0500
Message-ID: <43664B31.3000305@f0rmula.com>
Date: Mon, 31 Oct 2005 16:49:53 +0000
From: James Hansen <linux-kernel-list@f0rmula.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel-list <linux-kernel@vger.kernel.org>
Subject: Trouble unloading a module..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've having trouble unloading a kernel module for a PCI card that I'm 
porting to 64bit linux.  It doesn't seem to be unloading correctly.  
It's tested, stable and unloads perfectly on a 32bit machine, running 
2.6.10 (and all other 32bit kernels I've tried).

However, on a 64bit machine (unofficial amd/emt64 debian with 2.6.8), 
even though it seems to unload corrrectly, I get a kernel oops if an 
application that uses the driver attempts to connect to the device after 
it's been unloaded.

Being relatively inexperienced at kernel programming, does this point to 
anything that might be obvious to any of you, yet not to me? :)   Or are 
there any common stumbling blocks in terms of unloading modules on 64bit 
linux.

Thanks for any suggestions.

James
