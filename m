Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUCIXiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCIXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:38:09 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:31492 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S262463AbUCIXhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:37:45 -0500
Message-ID: <404E554E.7090403@rlknight.com>
Date: Tue, 09 Mar 2004 15:37:50 -0800
From: Rick Knight <rick@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org
CC: Linux Kernel Org <linux-kernel@vger.kernel.org>
Subject: Re: Dummy network device
References: <404E4F34.7000301@rlknight.com> <20040309152126.5c59d731.davem@redhat.com>
In-Reply-To: <20040309152126.5c59d731.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Tue, 09 Mar 2004 15:11:48 -0800
>Rick Knight <rick@rlknight.com> wrote:
>
>  
>
>>I found the answer. From the archive. Decided to look at dummy.c and 
>>numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
>>like a charm.
>>
>>Question/Suggestion, couldn't this be made an option at configuration? 
>>Kind of like number_of_ptys=256.
>>    
>>
>
>Specify "numdummies=3" on the module load command line.
>  
>
>It's supposed to be changeable at module load time, without
>rebuilding it.  Try this e.g.:
>
>modprobe dummy numdummies=4
>
>--
>~Randy
>  
>
Randy, David,

Thanks for the replies.

I did try 'modprobe dummy numdummies=3', however, I didn't quote 
numdummies=3. Are the quote required? Is there a modprobe.conf option? 
Probably "options dummy "numdummies=3".

Thanks,
Rick Knight
(rick@rlknight.com)

