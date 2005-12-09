Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVLIOsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVLIOsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVLIOsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:48:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30669 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932145AbVLIOso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:48:44 -0500
Message-ID: <43999947.5020300@us.ibm.com>
Date: Fri, 09 Dec 2005 09:48:39 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu> <20051209120244.GL27946@ftp.linux.org.uk> <43999199.70608@us.ibm.com> <20051209143445.GM27946@ftp.linux.org.uk>
In-Reply-To: <20051209143445.GM27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Fri, Dec 09, 2005 at 09:15:53AM -0500, JANAK DESAI wrote:
>  
>
>>To answer Ingo's question, we did look at other flags when I started. 
>>However,
>>I wanted to keep the system call simple enough, with atleast namespace 
>>unsharing,
>>so it would get accepted. In the original discussion on fsdevel, 
>>unsharing of vm
>>was mentioned as useful so I added that in addition to namespace unsharing.
>>    
>>
>
>So make that a series...  Note that it can be merged gradually - adding
>and debugging the unsharing of fs, files, etc. can be done independently
>and with no ABI changes.
>  
>

Ok, thanks. Will do.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

