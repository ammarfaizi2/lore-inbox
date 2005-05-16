Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVEPOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVEPOwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVEPOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:52:38 -0400
Received: from [80.247.74.3] ([80.247.74.3]:9874 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261670AbVEPOu6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:50:58 -0400
Message-Id: <6.2.1.2.2.20050516164236.05922a30@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 16:50:55 +0200
To: Eric Dumazet <dada1@cosmosbay.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4288AB6A.3060106@cosmosbay.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
 <428898CF.5060908@cosmosbay.com>
 <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
 <4288AB6A.3060106@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16.17 16/05/2005, Eric Dumazet wrote:

>Roberto Fichera a écrit :
>
>>
>>>But still you need a 4GB/4GB user/kernel split, because the standard is 
>>>3GB/1GB.
>>
>>Why I need 4GB/4GB split? What are the beneficts?
>
>Well... 4GB for your process is better than 3GB, that's 33% more space...

Right! So, the 4GB/4GB split and tmpfs pair should be the best solution to
address as much memory possible on a single user process.

>If your process is cpu bounded (and not issuing too many system calls),
>then 4GB/4GB split let it address more ram, reducing the need to shift 
>windows in
>mmaped files for example.

... any source code that explain better what you say ;-)!


>Eric
>

Roberto Fichera. 

