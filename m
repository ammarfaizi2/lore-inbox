Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUHVFBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUHVFBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHVFBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:01:12 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:41116 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266143AbUHVFBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:01:11 -0400
Message-ID: <412827DF.1080408@yahoo.com.au>
Date: Sun, 22 Aug 2004 14:58:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Thomas Davis <tadavis@lbl.gov>, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.8.1-mm3
References: <20040820031919.413d0a95.akpm@osdl.org>	<412821C4.7060402@lbl.gov> <20040821214824.4bf5e6fd.akpm@osdl.org>
In-Reply-To: <20040821214824.4bf5e6fd.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thomas Davis <tadavis@lbl.gov> wrote:

>>3) Interactivity performance when compiling a kernel (make rpm) sucks.  I have a Dell Poweredge 400SC, with a Hyper threaded P4/1GB of ram, ATI Radeon 9600 based video.  Load average jumps to the 4's, and stays there - while each cpu in the hyper thread shows about 50% idle time.  Mouse pointer jumps all over the place, mouse clicks are lost, menus are slow to drop down, etc..
> 
> 
> Ingo found a ghastly performance problem with X, but that'll be present in
> 2.6.8.1 as well.

The other thing is I may have botched moving my scheduler on top of smtnice.
I hadn't tested that too well (I have an HT system, but it doesn't run X).

If you get time, could you try turning off CONFIG_SCHED_SMT - if that still
doesn't help, try turning off hyperthreading completely. Thanks.
