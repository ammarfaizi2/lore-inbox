Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWFSUMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWFSUMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFSUMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:12:36 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:22166 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S964883AbWFSUMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:12:35 -0400
Message-ID: <44970522.9030404@free-electrons.com>
Date: Mon, 19 Jun 2006 22:12:18 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       chase.venters@clientec.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Option to clear allocated kernel memory before freeing it?
References: <4496B92A.3010907@free-electrons.com> <Pine.LNX.4.61.0606191145470.4384@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606191145470.4384@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase, Dick,
> No. Memory is cleared before being mapped to user-space. Memory
> that is allocated for use by the kernel is never cleared by default.
> To do so would waste valuable time for nothing gained.
>
>   
>> Unless I'm missing something, uncleared memory previously used for
>> kernel allocations could later be recycled for user allocations, making
>> it possible for a user program to access sensitive driver data if it's
>> lucky.
>>     
>
> Wrong. You are missing a lot.
>   
Oops, I realize I was really missing a lot! Thank you very much for 
leading me to the right path!

    Cheers,

    Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)..

