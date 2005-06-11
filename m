Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVFKHEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFKHEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVFKHEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:04:08 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:25008 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261622AbVFKHEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:04:04 -0400
Message-ID: <42AA8CDF.1020104@yahoo.com.au>
Date: Sat, 11 Jun 2005 17:03:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] export generic_drop_inode()
References: <20050611021805.GM1153@ca-server1.us.oracle.com>
In-Reply-To: <20050611021805.GM1153@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:

> @@ -1056,6 +1056,8 @@
>  		generic_forget_inode(inode);
>  }
>  
> +EXPORT_SYMBOL(generic_drop_inode);
> +

I think it is best to default these to EXPORT_SYMBOL_GPL to be on the
safe side, unless you have the agreement of the authors of the code, in
which case I beg your pardon.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
