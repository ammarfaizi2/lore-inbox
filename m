Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTHORC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHORCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:02:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:25300 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270142AbTHORCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:02:23 -0400
Date: Fri, 15 Aug 2003 18:00:26 +0100
From: Dave Jones <davej@redhat.com>
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 + ksymoops
Message-ID: <20030815170026.GA864@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, war <war@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0308151028050.28412@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0308151028050.28412@p500>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:29:00AM -0400, war wrote:
 > What could this mean?
 > 
 > Trace; c0114ef2 <schedule_timeout+52/d0>
 > Trace; c0114e50 <change_page_attr+1e0/230>
 > Trace; c0120262 <del_timer+8d2/e50>
 > Trace; c0108f13 <__up_wakeup+125b/1698>

That you mismatched the System.map with the kernel that oopsed,
and decoded the wrong symbols.

 > 346 warnings and 14 errors issued.  Results may not be reliable.

Really.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
