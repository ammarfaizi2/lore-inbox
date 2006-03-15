Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752059AbWCOM2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWCOM2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWCOM2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:28:35 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:335 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752059AbWCOM2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:28:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XElVqfm4AQW6L715WhltNvZy3UCuDRfqJ7o0XtQ7BHyA87jneo2nZw5IBvd/eY1KLWVYrzHbSY6oLMed7HPBSMaJmns8axxZa10q9HYEpWWZSkMdguWTPzsdsEF7yy5USLbekmFr4/538i7K4ihvNvHppRo3hhkpD9467D4QxZU=  ;
Message-ID: <44180784.6020608@yahoo.com.au>
Date: Wed, 15 Mar 2006 23:24:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ORMAP
References: <44178429.90808@comcast.net>
In-Reply-To: <44178429.90808@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> And looking through the recent discussions I see in one thread...
> 
> Willy Tarreau wrote:
> 
> 
>>It depends a lot on what people do with it in fact. For instance, it
>>works better in memory-constrained systems, probably thanks to rmap.
>>I have one 2.6 running reliably on my web server (hppa) where 2.4
>>regularly oopsed because of low memory.
> 
> 
> 
> This reminds me, what the hell ever happened to ORMAP?  That object
> based rmap thingy I tried out in one of wli's patches made my system
> boot like 3 times faster.  There were other cool things going on that I
> never got to try too, never saw that all out to fruition.
> 
> Status on some of the elements in the old 2.6-wli series from around
> there would be nice.  I'm curious as to what has gone in.
> 

2.6 has an object based rmap system working nicely for quite
a while now (though it was probably not exactly what you saw
in the -wli tree, but a derivative).

It would be surprising if that made your system boot 3 times
faster though (unless it was on the edge of a swap storm or
something)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
