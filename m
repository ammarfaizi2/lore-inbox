Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWCVHX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWCVHX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWCVHX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:23:27 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:31638 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751039AbWCVHX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:23:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b5iMIvePv+s6UTvWSILMqGd0EXBRxlsIRJX++2XI/pIw75Tk0kaXGPDG4b84LRnAQl3wwPzQEVnsp4zrmkgv7QpOxFfrZxMxTOam199VHTE8HDaYPggCNK52ObCK3uMh6bdzBhVfWt8ggappk6qAkEm2+QdlBbayJ1qNl6MPg3k=  ;
Message-ID: <4420FB66.3090206@yahoo.com.au>
Date: Wed, 22 Mar 2006 18:23:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>	 <441FEFC7.5030109@yahoo.com.au>	 <bc56f2f0603210733vc3ce132p@mail.gmail.com>	 <442098B6.5000607@yahoo.com.au> <bc56f2f0603212137s727ff0edu@mail.gmail.com>
In-Reply-To: <bc56f2f0603212137s727ff0edu@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> The name "Wired" could be changed to which one most kids think better
> fits the job.
> 
> I choosed "Wired" for:
> "Locked" will conflict with PG_locked bit of a pags.
> "Pinned" indicates a short-term lock,so not fits the job too.
> 

Err we're going around in circles here. This tangent started because
I suggested that you could call them "mlock" or "mlocked".

But don't get too hung up on the naming. I pointed out quite a lot
of much more fundamental problems.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
