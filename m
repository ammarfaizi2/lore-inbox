Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVHBASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVHBASP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVHBAPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:15:51 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:12136 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261394AbVHBAOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:14:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bZ/OhOJTwWvOjbGMVP93T1AlD1z0BFQffn5n9boDMUwfd8kONHAopIb1WlQ9ua1bLFlggSSTeNeFpY15i5JzNABkLgQUXeNGWVPR5hO+cpKcFqZ2txSCOzT+7Fle8Tk6AWEsw73Ci3lDTaG9HHN7ECbTqpZVUIPbdY2OG836JrI=  ;
Message-ID: <42EEBAE1.7050002@yahoo.com.au>
Date: Tue, 02 Aug 2005 10:14:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508010833250.14342@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Mon, 1 Aug 2005, Nick Piggin wrote:
>
>>Not sure if this should be fixed for 2.6.13. It can result in
>>pagecache corruption: so I guess that answers my own question.
>>
>
>Hell no.
>
>This patch is clearly untested and must _not_ be applied:
>
>

Yes, I meant that the problem should be fixed, not that the
patch should be applied straight away.

I wanted to get discussion going ASAP. Looks like it worked :)
I'll catch up on it now.


Send instant messages to your online friends http://au.messenger.yahoo.com 
