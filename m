Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992729AbWJTTaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992729AbWJTTaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992732AbWJTTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:30:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992729AbWJTTaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:30:21 -0400
Message-ID: <453923C9.7000808@redhat.com>
Date: Fri, 20 Oct 2006 14:30:17 -0500
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (update) more helpful WARN_ON and BUG_ON messages
References: <4538F81A.2070007@redhat.com> <4538FF32.8050604@sandeen.net>
In-Reply-To: <4538FF32.8050604@sandeen.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:

>> Printing out the failing condition as a string would make this more helpful IMHO.
>>
>> This is mostly just compile-tested... comments?

hmm for reference the extra strings add about 16k to my bzImage on
x86_64... I suppose this could be put under CONFIG_DEBUG if that's too
distressing.

-Eric
