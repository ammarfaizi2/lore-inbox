Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJMI4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJMI4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJMI4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:56:35 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48785 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266459AbUJMI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:56:32 -0400
Date: Wed, 13 Oct 2004 18:02:06 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c
In-reply-to: <16748.60002.875945.950324@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: akepner@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       akpm@osdl.org, jbarnes@sgi.com
Message-id: <416CEF0E.1060406@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
 <16748.57721.66330.638048@napali.hpl.hp.com> <416CEADA.2060207@jp.fujitsu.com>
 <16748.60002.875945.950324@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

>>>>>>On Wed, 13 Oct 2004 17:44:10 +0900, Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> said:
> 
> 
>   Hiroyuki> My purpose was to reduce # of page fault when
>   Hiroyuki> ia64_pfn_valid() is called.  It is called heavily in
>   Hiroyuki> bad_range() (in mm/page_alloc.c) now.
> 
> At the expense of ignoring perfectly good memory?  Or did I miss something?
> 
> 	--david

Am I ignoring some good memory ?
I think GRANULEROUNDDOWN(start)/GRANULEROUNDUP(end) only expand valid pfn range,
do I misunderstanding something ?



-- Kame
