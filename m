Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbUKVUam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUKVUam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKVTXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:23:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53632 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262374AbUKVTWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:22:01 -0500
Message-ID: <41A23C89.6090903@sgi.com>
Date: Mon, 22 Nov 2004 13:22:49 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andreas Schwab <schwab@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122162214.GE21861@wotan.suse.de> <jept25yggg.fsf@sykes.suse.de> <20041122165425.GG21861@wotan.suse.de>
In-Reply-To: <20041122165425.GG21861@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, apparently SIGPROF is delivered in both the ITIMER_PROF and
pmu interrupt cases, so if we special case that signal we should
be fine.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
