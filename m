Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVBUEPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVBUEPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBUEPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:15:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:44765 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261756AbVBUEPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:15:44 -0500
Message-ID: <42196182.1090604@sgi.com>
Date: Sun, 20 Feb 2005 22:20:18 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de>
In-Reply-To: <20050220214922.GA14486@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>
>>But we are least at the level of agreeing that the new system
>>call looks something like the following:
>>
>>migrate_pages(pid, count, old_list, new_list);
>>
>>right?
> 
> 
> For the external case probably yes. For internal (process does this
> on its own address space) it should be hooked into mbind() too.
> 
> -Andi
> 
That makes sense.  I will agree to make that part work, too. as part
of this.  We will probably do the external case first, because we have
need for that.

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
