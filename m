Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbTHURGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHUREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:04:16 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:40091 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262806AbTHURDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:03:35 -0400
Message-ID: <3F449866.1070406@softhome.net>
Date: Thu, 21 Aug 2003 12:01:10 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Spiridonov <spiridonov@gamic.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to turn off, or to clear read cache?
References: <mzNF.3z3.47@gated-at.bofh.it> <mB2M.4Jv.35@gated-at.bofh.it> <mCi4.5Kq.3@gated-at.bofh.it>
In-Reply-To: <mCi4.5Kq.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Spiridonov wrote:
> Denis Vlasenko wrote:
> 
>> umount/mount cycle will do it, as well as intentional OOMing the box
>> (from non-root account please;)
> 
> 
> OOMing doesn't help also, since kernel starts to swap and I have 
> performance degradation after. Swithching off the swap is dangerous in 
> conjunction with OOMing.
> 

   indirectly, patch mentioned in this mail can help:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106142721228497&w=2

   it provides a way to limit read cache - so it is easier to flush it.

P.S. will love to see something like this in 2.6. And for 2.4 too.

