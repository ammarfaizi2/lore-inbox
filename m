Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUK3QCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUK3QCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUK3QCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:02:09 -0500
Received: from gate.corvil.net ([213.94.219.177]:7441 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262130AbUK3QCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:02:06 -0500
Message-ID: <41AC9972.2070305@draigBrady.com>
Date: Tue, 30 Nov 2004 16:01:54 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA887@azsmsx406> <Pine.LNX.4.53.0411301654360.20450@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411301654360.20450@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>	I've written a 2.4 kernel module where I'm trying to walk and
>>record all of the physical memory contents in an x86 system. I have the
>>following code fragment that does it but I suspect I'm missing a portion
>>of the memory:
>>
>>Is there a better way to record all of the contents of physical memory
>>since what I have above doesn't seem to get everything?
> 
> 
> Maybe something userspace based?
> 
> dd_rescue /dev/mem copyofmem

Doesn't equate to a power of 2
(nor does `grep MemTotal /proc/meminfo`)

Pádraig.
