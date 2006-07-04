Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGDR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGDR07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGDR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 13:26:59 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:50559 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932196AbWGDR06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 13:26:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=R66x9d8ETcCYC6mmSZpJzvHqa8alpLtkDr/v28D5rvW+ijn119jUQ6cWuPhBaKpbu0mvmh1ULDKhVHDzI/k2ALMJG7q/FbTURLM29c4ixGxhbyg/EPkFU5KBZO61hg0vcBfgIEbHrN5mFzQVC+ftCngN6ZcEO7ZuNuBj73JsLR4=  ;
Message-ID: <44AA9D17.2010005@yahoo.com.au>
Date: Wed, 05 Jul 2006 02:53:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@suspend2.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <200606271634.43662.nigel@suspend2.net> <44A3FE3B.6070103@yahoo.com.au> <200607042054.55925.nigel@suspend2.net>
In-Reply-To: <200607042054.55925.nigel@suspend2.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

>>Haven't you suspended the other threads at this point?
>>
>>What are the consequences of allocating memory?
> 
> 
> Did you see my reply to these questions?

Hi Nigel,

Yes I did, sorry I thought I replied but it seems not.

I do think taking the pages off the LRU, or otherwise pinning
them on it does sound like a better approach.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
