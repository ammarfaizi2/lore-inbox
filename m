Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTJLW14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJLW14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:27:56 -0400
Received: from natsmtp01.rzone.de ([81.169.145.166]:38135 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261168AbTJLW1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:27:54 -0400
Message-ID: <3F89D567.6080901@softhome.net>
Date: Mon, 13 Oct 2003 00:27:51 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
References: <FNmF.1ky.9@gated-at.bofh.it> <FNFZ.1JI.3@gated-at.bofh.it> <FP59.3H0.17@gated-at.bofh.it> <FVkc.42S.5@gated-at.bofh.it>
In-Reply-To: <FVkc.42S.5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> reiserfs is not warranted to work on corrupted hdds.....

   Is there any kind of error statistics for hard drives?

   Geometry is known.
   I suspect that structure of damages, caused by contact of plates 
surface with head, can be classified.

   It may be possible to classify manufacturing glitches. I think HD 
producers have this kind of classification/statistics - to improve 
quality, keeping price low.

   Actually what I'm thinking of: some kind of design rules for file 
systems, how to minimize crashing due to hdd glitches.
   Let's say, if some of hdd regions are know to be more error prone - 
desing fs to use those regions less.
   If hdd damages used to have some specific structure - design file 
system to keep renundant data in regions which are less likely to be 
lost both at the same time. So renundancy would make sense.

   Is there any thing like this?

   Or file systems now do outlive hard drives?-)

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

