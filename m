Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTJ3MEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJ3MEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:04:45 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:25483 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262356AbTJ3MEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:04:43 -0500
Message-ID: <3FA0FE57.60100@softhome.net>
Date: Thu, 30 Oct 2003 13:04:39 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Things that Longhorn seems to be doing right
References: <LUlv.31e.5@gated-at.bofh.it> <M7iG.41B.7@gated-at.bofh.it> <MagC.82U.7@gated-at.bofh.it> <Mcig.2uf.1@gated-at.bofh.it> <Mcs2.2FJ.5@gated-at.bofh.it>
In-Reply-To: <Mcs2.2FJ.5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> select ID,STATUS,SEVERITY,PRIORITY,SUMMARY
> from bugs
> where	(SEVERITY == 1 or SEVERITY == 2 or SEVERITY == 3) and 
> 	(PRIORITY == 1 or PRIORITY == 2 or PRIORITY == 3) and 
> 	(STATUS == "new" or STATUS == "open" or STATUS == "assigned")
> order by
> 	ID
> 

   In fact it mustn't be a text.
   Some kind of encoding like ASN.1 will do the job.
   Parsing text in C - is really painful.

   my 0.02 euro.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

