Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUHFR26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUHFR26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUHFRST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:18:19 -0400
Received: from main.gmane.org ([80.91.224.249]:42680 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268206AbUHFRR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:17:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
Date: Fri, 06 Aug 2004 10:17:43 -0700
Message-ID: <87ekmkw5hk.fsf@benpfaff.org>
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it>
 <m3wu0cgv6q.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-6-66-193.client.comcast.net
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:FeOQekJWDcRPIJp9cdXizFo682A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 6 Aug 2004, Andi Kleen wrote:
>> 
>> You could use .altinstructions to patch a jump in at runtime
>> based on CPU capabilities. Assuming MMX is really faster of course.
>
> I seriously doubt that the MMX code could be faster.

For what it's worth, about a year about I tested both Gladman's
MMX and non-MMX code on a Pentium 4.  The non-MMX code was
consistently significantly faster in every scenario I could come
up with.
-- 
I love deadlines.
I love the whooshing noise they make as they go by.
--Douglas Adams

