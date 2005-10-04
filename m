Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVJDOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVJDOMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVJDOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:12:34 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:25360 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S932470AbVJDOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:12:33 -0400
Message-ID: <43428DCC.7030808@oxley.org>
Date: Tue, 04 Oct 2005 15:12:28 +0100
From: Felix Oxley <lkml@oxley.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: make xconfig fails for older kernels
References: <4TJDn-2mm-3@gated-at.bofh.it> <4341FBA8.3020208@shaw.ca> <200510041034.07837.lkml@oxley.org> <43428BD3.9090407@oxley.org>
In-Reply-To: <43428BD3.9090407@oxley.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Felix Oxley wrote:
> 
>> I think you have nailed it.  I'm using GCC 4.0.2. Incidentally the 
>> first 2.6 kernel in which this issue was resolved is 2.6.9.
> 
> 
> For the record, the first version of the stock kernel which will build 
> for me with GCC 4.0.2 is 2.16.12. (Using a minimal .config)
> 

To clarify, using GCC 4.0.2 I get the following:

	<= 2.6.9 	cannot make config/menuconfig/xconfig
	2.6.10 + 11	build fails in i386/asm(?)
	2.6.12		builds ok


Felix
