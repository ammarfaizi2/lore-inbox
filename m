Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264454AbTCXWI5>; Mon, 24 Mar 2003 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbTCXWI5>; Mon, 24 Mar 2003 17:08:57 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:42624 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264454AbTCXWI4>; Mon, 24 Mar 2003 17:08:56 -0500
Message-ID: <3E7F8486.8000008@nortelnetworks.com>
Date: Mon, 24 Mar 2003 17:19:50 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com> <20030324200105.GA5522@work.bitmover.com> <543480000.1048540161@flay> <20030324153602.28b44e23.akpm@digeo.com> <20030324220435.GA11421@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> work ~/LMbench2/bin/i686-pc-linux-gnu ENOUGH=1000000 time bw_pipe
> Pipe bandwidth: 655.37 MB/sec
> real    0m23.411s
> user    0m0.480s
> sys     0m1.180s
> 
> work ~/LMbench2/bin/i686-pc-linux-gnu time bw_pipe
> Pipe bandwidth: 809.81 MB/sec
> 
> real    0m2.821s
> user    0m0.480s
> sys     0m1.180s

Why the difference?  Is it being scheduled out?  Should lmbench be (optionally) 
putting itself into a realtime scheduling class?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

