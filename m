Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTDJVFS (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTDJVFR (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:05:17 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:7100 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S264169AbTDJVFQ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:05:16 -0400
Message-ID: <3E95DF4A.7060203@nyc.rr.com>
Date: Thu, 10 Apr 2003 17:16:58 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401 Debian/1.3-4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
References: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Hi!
> 
>   Here are the latest framebuffer changes. Some driver updates and a 
> massive cleanup of teh cursor code. Tony please test it on the i810 
> chipset. I tested it on the Riva but there is one bug I can't seem to 
> find. Please test this patch. It is against 2.5.67 BK. It shoudl work 
> against 2.5.67 as well. 
> 
> Please test. 

I get an oops on boot in function fb_set_var (called from 
radeon_init_disp).  This might simply be because I don't have the same 
version of fbmem.c (I had to apply that hunk of the patch by hand) 
although I have source of 2.5.67.

Anyone else not able to apply all parts of the patch cleanly?
Anyone else seeing this problem?


-- 
(o- j o h n  e  w e b e r
//\  weber@sixbit.org
v_/_  http://weber.sixbit.org/
=====  aim/yahoo/msn: worldwidwebers

