Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbTJQIPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTJQIPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:15:49 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:39040 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263334AbTJQIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:15:47 -0400
Message-ID: <3F8FA52E.2090906@softhome.net>
Date: Fri, 17 Oct 2003 10:15:42 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
References: <GTJr.60q.17@gated-at.bofh.it> <GU2N.6v7.17@gated-at.bofh.it> <GVBC.Ep.23@gated-at.bofh.it> <Hjkq.3Al.1@gated-at.bofh.it> <Hkgx.4Vu.7@gated-at.bofh.it> <HkA0.5lh.9@gated-at.bofh.it> <HnxT.3BB.27@gated-at.bofh.it>
In-Reply-To: <HnxT.3BB.27@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Val Henson wrote:
>>   of many kinds of hardware errors. Further analysis shows that this
>>   approach is not as risk-free as it seems at first glance."
> 
> 
> I'm curious if anyone has done any work on using multiple different 
> checksums?  For example, the cost of checksumming a single block with 
> multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 

   With sha1 you probably have 8-9 nines reliability.
   You can improve this - but still adding nines doesn't mean it 
(reliability) becomes 100%.

   my 0.02c.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

