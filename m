Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWDXLnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWDXLnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWDXLnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:43:09 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:55981 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750738AbWDXLnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:43:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cp7Vbb7oX8hg3AiRuB6LvDbzSZ8htgsowXl3u/imohwD8/UuoVWNpI1RlBsaobqulTEHJsg4rCsYq4gD/CFRPjrISIZLVH2Lx8Czrie/iZsO5erHwuTY1mMmuS6ndy0aaike79trHntuWn9Bh8yf4kGM0X+66k6Y/LIgjuS+RMc=  ;
Message-ID: <444CB588.6090105@yahoo.com.au>
Date: Mon, 24 Apr 2006 21:24:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
References: <200511142327.18510.a1426z@gawab.com> <200604240756.42483.a1426z@gawab.com> <20060423221157.6a4b5c8e.akpm@osdl.org> <200604241412.13267.a1426z@gawab.com>
In-Reply-To: <200604241412.13267.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

> Could do that by:
> 
> 	# echo 1 > /proc/sys/kernel/su-pid
> 
> which would imply nr-threads = 1
> 	
> So maybe introduce /proc/sys/kernel/nr-threads to allow that to be variable, 
> but this isn't really critical.

Why not just have su-nr-threads?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
