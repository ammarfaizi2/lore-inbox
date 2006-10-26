Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752136AbWJZM30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWJZM30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbWJZM30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:29:26 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:16564 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752136AbWJZM3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:29:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Iori+1tyn9yFmUtw8Ozzl5xLtkMs799XHWWmV9plsRhDH39gWL/h2LzVImDcyb/oPdzh5qYE8bJtHfYYUImKZ7XXB4J0haXN6DUbEiZLoR9wBDISs2ZpbgUxITjW14td+Q3qgqBjATxlP0lSf2BFUW8XLVEahX5Fs1LaTtlAmDs=  ;
Message-ID: <4540AA20.1090005@yahoo.com.au>
Date: Thu, 26 Oct 2006 22:29:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Holden Karau <holden@pigscanfly.ca>
CC: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       holden.karau@gmail.com
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes
 in fat_mirror_bhs [really unmangled]
References: <4540A32E.5050602@pigscanfly.ca>
In-Reply-To: <4540A32E.5050602@pigscanfly.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holden Karau wrote:
> From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
> 
> This is an attempt at improving fat_mirror_bhs in sync mode [namely it
> writes all of the data for a backup block, and then blocks untill
> finished]. The old behaviour would write & block in smaller chunks, so
> this should be slightly faster. It also removes the fixme requesting
> that it be fixed to behave this way :-)
> Signed-off-by: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com

So how much is performance improved?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
