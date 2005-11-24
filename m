Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVKXXrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVKXXrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbVKXXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:47:47 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:58054 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1161074AbVKXXrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:47:47 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491 
In-reply-to: Your message of "Thu, 24 Nov 2005 07:50:49 -0000."
             <Pine.LNX.4.61.0511240747590.5688@goblin.wat.veritas.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Nov 2005 10:47:41 +1100
Message-ID: <25093.1132876061@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005 07:50:49 +0000 (GMT), 
Hugh Dickins <hugh@veritas.com> wrote:
>On Wed, 23 Nov 2005, Dave Jones wrote:
>> On Wed, Nov 23, 2005 at 11:35:15PM +0000, Alistair John Strachan wrote:
>>  > On Wednesday 23 November 2005 23:24, Con Kolivas wrote:
>>  > > Chen, Kenneth W writes:
>>  > > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
>>  > > >
>>  > > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
>>  > > >
>>  > > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
>>  > >
>>  > >                        ^^^^^^^^^^
>>  > >
>>  > > Please try to reproduce it without proprietary binary modules linked in.
>>  > 
>>  > AFAIK "G" means all loaded modules are GPL, P is for proprietary modules.
>> 
>> The 'G' seems to confuse a hell of a lot of people.
>> (I've been asked about it when people got machine checks a lot over
>>  the last few months).
>> 
>> Would anyone object to changing it to conform to the style of
>> the other taint flags ? Ie, change it to ' ' ?
>
>Please, please do: it's insane as is.  But I've CC'ed Keith,
>we sometimes find the kernel does things so to suit ksymoops.

'G' is not one of mine, I find it annoying as well.

