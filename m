Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVD0Qml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVD0Qml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVD0Qmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:42:40 -0400
Received: from [213.170.72.194] ([213.170.72.194]:35051 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261617AbVD0Qmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:42:39 -0400
Message-ID: <426FC0FE.2090900@oktetlabs.ru>
Date: Wed, 27 Apr 2005 20:42:38 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any way to find out kernel memory usage?
References: <426FBFED.9090409@nortel.com>
In-Reply-To: <426FBFED.9090409@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> One idea we had to prevent this in the future is to configure the OOM 
> killer to reset the system if the kernel uses more than a certain amount 
> of memory.  (Reset is better than hang for our purposes.) Is there any 
> way to find out how much memory the kernel is using?  I don't see 
> anything in /proc, but maybe something internal that isn't currently 
> exported?
> 
How about /proc/slabinfo ?


-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
