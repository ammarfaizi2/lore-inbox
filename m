Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVAUXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVAUXdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVAUXdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:33:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:40848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbVAUXak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:30:40 -0500
Date: Fri, 21 Jan 2005 15:35:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net, ltp-list@lists.sourceforge.net,
       hanrahat@osdl.org
Subject: Re: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP Results for
 2.6.x and 2.4.x)
Message-Id: <20050121153520.6a7c08dd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0501211058080.32650-100000@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.33.0501181540480.11396-100000@osdlab.pdx.osdl.net>
	<Pine.LNX.4.33.0501211058080.32650-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington <bryce@osdl.org> wrote:
>
> cmdline="mkfifo gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r
> -r 1-4096 gffifo18"
> contacts=""
> analysis=exit
> initiation_status="ok"
> <<<test_output>>>
> growfiles(gf13): 17094 DEBUG1 Using random seed of 1106350453
> Kernel panic - not syncing: Out of memory and no killable processes...
> 
> 
> The full output are available at these links:
> 
> FAIL   LTP  2.6.11-rc1  SuSE 9.0  2-way  http://khack.osdl.org/stp/300213/
> FAIL   LTP  2.6.11-rc1  SuSE 9.2  2-way  http://khack.osdl.org/stp/300219/
> FAIL   LTP  2.6.11-rc1  SuSE 9.2  1-way  http://khack.osdl.org/stp/300209/
> 
> OK     LTP  2.6.10      SuSE 9.2  2-way  http://khack.osdl.org/stp/300230
> OK     LTP  2.6.10      SuSE 9.0  2-way  http://khack.osdl.org/stp/300229
> OK     LTP  2.6.10      RH 9.0    2-way  http://khack.osdl.org/stp/300228
> OK     OPTS 2.6.11-rc1  RH 9.2    2-way  http://khack.osdl.org/stp/300227

I am unable to find the oops trace amongst all that stuff.  Help?

(It would have been handy to include it in the bug report, actually)
