Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTHVEOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 00:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTHVEOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 00:14:33 -0400
Received: from main.gmane.org ([80.91.224.249]:64490 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263015AbTHVEOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 00:14:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: "ctrl+c" disabled!
Date: Fri, 22 Aug 2003 00:14:28 -0400
Message-ID: <bi45b6$kor$1@sea.gmane.org>
References: <036601c367e0$01adabc0$2a01010a@avwindows> <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows> <3F45830A.5C0F5BCA@gmx.de> <053301c3685c$9ea6fe50$2a01010a@avwindows>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <053301c3685c$9ea6fe50$2a01010a@avwindows>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill J.Xu wrote:
> after run od -tx1, the following is the result
> ------------------------------------------------
> bash-2.05# ./od -tx1
> 0000000

That's after you pressed ^C in your terminal program? What you have 
there shows that od has not received any characters.

Pick another control character, and use 'stty intr' to set that as your 
interrupt character. I don't have any experience with SecureCRT, but it 
may use ^C to implement the Windows Edit->Copy function.

-- 
Charles Lepple <ghz.cc!clepple>


