Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWH2BPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWH2BPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWH2BPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:15:52 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:15212 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750784AbWH2BPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:15:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=o+75P4ezjoTt6VC0B6wjltOKW81oypHKzfGPIaygXM8lWwT2kcwEi7pg+vJol614U2hn8KKrifw0dKlPiIiesxdTlqXaQrN8yxLr7cHL9rvfP+287lE9XE3lzJJZTro1fT1MOUTkizOjHvGz4Rm7MtQtWbKcHi5AByyavemsCQk=  ;
Message-ID: <44F3952B.5000500@yahoo.com.au>
Date: Tue, 29 Aug 2006 11:15:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
References: <44EFBEFA.2010707@student.ltu.se>	<20060828093202.GC8980@infradead.org> <20060828171804.09c01846.akpm@osdl.org>
In-Reply-To: <20060828171804.09c01846.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 28 Aug 2006 10:32:02 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> 
>>On Sat, Aug 26, 2006 at 05:24:42AM +0200, Richard Knutsson wrote:
>>
>>>Hello
>>>
>>>Just would like to ask if you want patches for:
>>
>>Total NACK to any of this boolean ididocy.  I very much hope you didn't
>>get the impression you actually have a chance to get this merged.
> 
> 
> I was kinda planning on merging it ;)
> 
> I can't say that I'm in love with the patches, but they do improve the
> situation.
> 
> At present we have >50 different definitions of TRUE and gawd knows how
> many private implementations of various flavours of bool.
> 
> In that context, Richard's approach of giving the kernel a single
> implementation of bool/true/false and then converting things over to use it
> makes sense.  The other approach would be to go through and nuke the lot,
> convert them to open-coded 0/1.

Well... we are programming in C here, aren't we ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
