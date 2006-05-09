Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWEIB7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWEIB7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 21:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWEIB7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 21:59:44 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:3721 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750834AbWEIB7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 21:59:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=w9299FNrhqv2uRgHNQCGc9X49Skxi3NaEGmvl7XkBC/2Ybtyz9N8tuRBvK3KHxvJi4l4pyTOrT9kxiTvNngwbC+TkA9QFeTf778SR3x5Em3cWoTy7AVM68VWvypk1fb8xNWg50zdYDq4mh5hzSukcjwKuqb0ga9+EWqKr/Xq7Jg=  ;
Message-ID: <445FF78B.9060803@yahoo.com.au>
Date: Tue, 09 May 2006 11:59:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] fix can_share_swap_page() when !CONFIG_SWAP
References: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain> <445ED495.3020401@yahoo.com.au> <Pine.LNX.4.64.0605081335030.7003@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605081335030.7003@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>On Mon, 8 May 2006, Nick Piggin wrote:
>
>>Looks like a good patch, nice catch. You should run it past Hugh but tend to
>>agree it would be nice to reuse the out of line can_share_swap_page, which
>>would fold beautifully with PageSwapCache a constant 0.
>>
>
>True; but I think Hua's patch is good as is for now, to fix
>that inefficiency.  I do agree (as you know) that there's scope for
>cleanup there, and that that function is badly named; but I'm still
>unprepared to embark on the cleanup, so let's just get the fix in.
>

Sure. Queue it up for 2.6.18?
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
