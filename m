Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVJKOvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVJKOvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVJKOvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:51:10 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:28863 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932106AbVJKOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:51:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ISSUjGh6MXcuQ7g39MBQGDRtEbrj6AQLyKhRFXUBZWfx65Nt6EHGWSi6KeA0PJxJmFxZJDG/Syq86BI0cQAY5FxuzkeYoxTIlujY36rtqI5AzBkNQUxu6sTrxjvFJXomZ4y8JRx3KUD/pC5r6kULifDahNw2axwMt+mDR9Oal6U=  ;
Message-ID: <434BCE80.2060405@yahoo.com.au>
Date: Wed, 12 Oct 2005 00:38:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Hugh Dickins <hugh@veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
References: <434B7F19.5040808@yahoo.com.au> <1129035883.23677.48.camel@localhost.localdomain> <434BC095.4050305@yahoo.com.au> <Pine.LNX.4.61.0510111454530.2950@goblin.wat.veritas.com> <434BCDF5.2080707@yahoo.com.au>
In-Reply-To: <434BCDF5.2080707@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Right. As a security issue it is nothing new, though probably it will
> be eaiser for big 64-bit systems to _unintentionally_ wrap the ZERO_PAGE
> refcount.
> 

Infinitely more probable in fact, considering it was impossible beforehand.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
