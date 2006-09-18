Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWIRAKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWIRAKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWIRAKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:10:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965163AbWIRAKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:10:10 -0400
Message-ID: <450DE3DE.50301@redhat.com>
Date: Sun, 17 Sep 2006 20:10:06 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: yogeshwar sonawane <yogyas@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
In-Reply-To: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yogeshwar sonawane wrote:
> Hi all,
> 
> We all know that in 32-bit OS, total 4GB memory space is divided in
> 3(user) + 1(kernel) space.
> 
> Similarly, what is the division/scenario in case of 64-bit OS ?

It depends on the architecture.

However, all 64 bit architectures have one thing in common.
There is so much address space available for both kernel and
userspace that we won't have to worry about a shortage for a
very long time.

Sure, people said that too when going from 16 bits to 32 bits,
but that was only a factor 2^16 difference.  This time it's the
square of the previous difference.

-- 
What is important?  What you want to be true, or what is true?
