Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVCCKlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVCCKlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCCKk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:40:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:27309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262505AbVCCKhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:37:47 -0500
Date: Thu, 3 Mar 2005 02:36:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc/locaavg definition
Message-Id: <20050303023650.63056ad1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503030100550.28740@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0503030100550.28740@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> wrote:
>
> from what I have been able to find under /Documentation /proc/loadavg is 
>  defined as giving three loadaverage numbers, 1 min, 5 min, 15 min.
> 
>  however as of 2.6.5ish timeframe there are a coupld of additional colums 
>  that do not appear to be documented
> 
>  the first is something #/# that could be # of running processes/total # of 
>  processes, but I can't find a definition of this anywhere

	number of currently ready-to-run threads
	/
	total number of threads in the machine
	the pid of the most-recently-created thread.

No idea why the last one is there.
