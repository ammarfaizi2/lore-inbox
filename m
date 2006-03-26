Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCZWht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCZWht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWCZWht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:37:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28644 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932148AbWCZWht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:37:49 -0500
Message-ID: <442717A6.3060708@us.ibm.com>
Date: Sun, 26 Mar 2006 14:37:26 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: sho@tnes.nec.co.jp
CC: linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
References: <20060325223358sho@rifu.tnes.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



sho@tnes.nec.co.jp wrote:

>Hi,
>
>>More information. I ran the test with "-onoreservation" thinking that
>>the patch didn't address "reservation code" issues and I still ran
>>into block allocation problems. Hope this helps.
>>
>
>As you said, the previous patches were broken because of my mailer,
>and part of them would be rejected.
>I'm re-sending them;  I have not changed them other than the mailer.
>Could you try new patches and check what happened?
>I have run fsx with these patches several times and the problems
>weren't reproduced.
>
>Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
>---
>

Sure. I will give it a spin.

BTW, did you really test them with > 8TB filesystem ?
I ran bunch of "dd"s to create few files and then ran mutiple copies of 
"fsx" tests.
Then I run into problems in few seconds of the tests.

Thanks,
Badari

>



