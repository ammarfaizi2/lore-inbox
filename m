Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTJPXP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTJPXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:15:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20651 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263288AbTJPXPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:15:22 -0400
Message-ID: <3F8F2637.4080007@austin.ibm.com>
Date: Thu, 16 Oct 2003 18:13:59 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: 2.6.0-test7-mm1
References: <3F8EAEB5.5040102@austin.ibm.com> <20031016075815.266e5c4b.akpm@osdl.org>
In-Reply-To: <20031016075815.266e5c4b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>On reboot after heavy IO loads (tiobench) I keep getting the following 
>> oops.
>>    
>>
>
>Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
>patches were not so great and need to be reverted.
>

Looks like that fixed it!

Steve

