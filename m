Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWGGCxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWGGCxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWGGCxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:53:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17030 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751098AbWGGCxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:53:39 -0400
Message-ID: <44ADCC22.6000609@zytor.com>
Date: Thu, 06 Jul 2006 19:51:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: early pagefault handler
References: <200607050745_MC3-1-C42B-9937@compuserve.com> <44ADC1C3.1020106@google.com>
In-Reply-To: <44ADC1C3.1020106@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Chuck Ebbert wrote:
>> +page_fault:
>> +    cld
> 
> My i386 lore is getting a little rusty, can the direction flag actually be
> random here?

Yes.

	-hpa
