Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUCLTOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUCLTOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:14:07 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:23954 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262398AbUCLTLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:11:32 -0500
Message-ID: <40520B2E.3010806@nortelnetworks.com>
Date: Fri, 12 Mar 2004 14:10:38 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
References: <Pine.LNX.4.44.0403121405170.6494-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403121405170.6494-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 12 Mar 2004, Chris Friesen wrote:
> 
> 
>>What happens when you have more than PAGE_SIZE processes running?
> 
> 
> Forked off the same process ?
> Without doing an exec ?
> On a 32 bit system ?
> 
> You'd probably run out of space to put the VMAs,
> mm_structs and pgds long before reaching this point ...

I'm just thinking of the "fork 100000 kids to test 32-bit pids" sort of 
test cases.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
