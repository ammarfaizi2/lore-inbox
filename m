Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbULXUGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbULXUGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 15:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbULXUGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 15:06:08 -0500
Received: from mrout1.yahoo.com ([216.145.54.171]:19611 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S261445AbULXUFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 15:05:46 -0500
Message-ID: <41CC7687.2010405@gmail.com>
Date: Sat, 25 Dec 2004 01:35:27 +0530
From: Arun C Murthy <acmurthy@gmail.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: at_fork & at_exit
References: <41C835C7.2010203@gmail.com> <Pine.LNX.4.61.0412211544430.22006@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412211544430.22006@yvahk01.tjqt.qr>
Content-Type: multipart/mixed;
 boundary="------------030807060906030409020102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807060906030409020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Engelhardt wrote:

>>Hi,
>>
>>Im looking for linux equivalent of the FreeBSD calls:
>>
>>1. at_fork
>>2. at_exit
>>    
>>
>I do not see such a hook in the kernel source tree, so adding your own seems 
>to only way.
>The places are in kernel/fork.c:copy_process() and 
>kernel/exit.c:__unhash_process
>  
>
  here's patches if someone else is interested... pls let me know if 
there are any improvements possible...

Arun

--------------030807060906030409020102
Content-Type: application/gzip;
 name="atforkexit.patch.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="atforkexit.patch.tar.gz"

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
--------------030807060906030409020102--
