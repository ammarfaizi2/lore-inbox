Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWEDP3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWEDP3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWEDP3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:29:10 -0400
Received: from [84.204.75.166] ([84.204.75.166]:42894 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751507AbWEDP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:29:08 -0400
Message-ID: <445A1DC3.8040908@oktetlabs.ru>
Date: Thu, 04 May 2006 19:29:07 +0400
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/13: eCryptfs] Header declarations
References: <20060504031755.GA28257@hellewell.homeip.net>	 <20060504033750.GD28613@hellewell.homeip.net>	 <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>	 <445A16B1.8080407@oktetlabs.ru> <1146756179.11422.8.camel@localhost>
In-Reply-To: <1146756179.11422.8.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Pekka Enberg wrote:
> 
>>>So, what's wrong with BUG_ON?
> 
>>I guess because this may be compiled off when no debugging/extra 
>>checking is needed.
>  
> But you shouldn't write assertions that you don't really need anyway.
> 
I wouldn't be so strict. Normally, you don't need them and disable as 
they slow you down. But when you are hunting a problem you enable them 
as they may catch it on an early stage. I don't see anything bad here...

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
