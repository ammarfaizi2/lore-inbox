Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUI0Uao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUI0Uao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUI0U0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:26:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52701 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267323AbUI0UZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:25:24 -0400
Message-ID: <4158782B.9000509@sgi.com>
Date: Mon, 27 Sep 2004 15:29:31 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>	<20040923194216.1f2b7b05.akpm@osdl.org>	<41543FE2.5040807@austin.ibm.com> <20040924150523.4853465b.akpm@osdl.org> <4154A5FF.6040206@austin.ibm.com>
In-Reply-To: <4154A5FF.6040206@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On question I have (and I'm sorry, I haven't had time to look at your
patch to sort this out) is what happens if the user supplies a rather
serious I/O size, will you read ahead multiples of that, or what
happens?  Or, for that matter, how well will it perform?

I've heard about HPC applications for IRIX that issue a 2GB read.  :-)

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

