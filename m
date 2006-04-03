Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDCIkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDCIkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDCIkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:40:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19335 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750930AbWDCIkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:40:41 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: oleg@tv-sign.ru, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.17-rc1] Reinstate const in next_thread() 
In-reply-to: Your message of "Mon, 03 Apr 2006 01:33:42 MST."
             <20060403013342.5e34c3ba.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Apr 2006 18:40:29 +1000
Message-ID: <25841.1144053629@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Mon, 3 Apr 2006 01:33:42 -0700) wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>> Before commit 47e65328a7b1cdfc4e3102e50d60faf94ebba7d3, next_thread()
>> took a const task_t.  Reinstate the const qualifier, getting the next
>> thread never changes the current thread.
>> 
>
>Can do, but why?  Does code generation improve?

I have not checked.  The const qualifier on this type of function falls
into the "better safe than sorry" category.

