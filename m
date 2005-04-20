Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVDTXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVDTXtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVDTXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:49:42 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:62397 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261844AbVDTXtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:49:25 -0400
Message-ID: <4266EBB1.1090806@jp.fujitsu.com>
Date: Thu, 21 Apr 2005 08:54:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Subject: Re: [RFC][PATCH] nameing reserved pages [1/3]
References: <42664654.5080409@jp.fujitsu.com> <20050420211018.GC3372@elf.ucw.cz>
In-Reply-To: <20050420211018.GC3372@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Pavel Machek wrote:
>          ~
> 	  missing e?
Oh, it's typo :(. thanks!

> 
> 
>>+	Reserved_At_Boot,
>>+	Max_Reserved_Types,
>>+	Page_Invalid = 0xff
>>+};
> 
> 
> You certainly use unusual naming convention here. Could we get
> reserved_at_boot instead? (I.e. all lowercase).
> 
Okay.
> 
> 
>>+static inline void set_page_reserved(struct page *page, unsigned char type)
>>+{
> 
> 
> Make it enum page_type type.

I'll do.

Thanks
-- Kame <kamezawa.hiroyu@jp.fujitsu.com>

