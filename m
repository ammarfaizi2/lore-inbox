Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUCIXLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUCIXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:11:42 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:30724 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S261997AbUCIXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:11:32 -0500
Message-ID: <404E4F34.7000301@rlknight.com>
Date: Tue, 09 Mar 2004 15:11:48 -0800
From: Rick Knight <rick@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Org <linux-kernel@vger.kernel.org>
Subject: Dummy network device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> After I upgraded to 2.6.3 from 2.4.20 I discovered that I can only get 
> 1 dummy device. I need to be able to load 3 dummy network devices. 
> Scouring the kernel archives, it looks like this can be accomplished 
> through MODULE_PARAMS, but I can find no information on the 
> module_params are or how to use them. I have dummy built as a module 
> and it does load at startup as dummy0. How do I get dummy1 and dummy2?
>
> In answering this message, please CC me.
>
> Thanks for your help,
> Rick Knight
> (rick@rlknight.com)


Never mind,

I found the answer. From the archive. Decided to look at dummy.c and 
numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
like a charm.

Question/Suggestion, couldn't this be made an option at configuration? 
Kind of like number_of_ptys=256.

Please CC  me with any response.

Thanks,
Rick Knight
(rick@rlknight.com)

