Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbUKKSxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbUKKSxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUKKSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:52:54 -0500
Received: from [194.90.79.130] ([194.90.79.130]:50190 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262316AbUKKRTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:19:33 -0500
Message-ID: <41939F21.2040008@argo.co.il>
Date: Thu, 11 Nov 2004 19:19:29 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap vs. O_DIRECT
References: <cmtsoo$j55$1@gatekeeper.tmr.com>	 <1100121230.4739.1.camel@betsy.boston.ximian.com>  <41937C1A.30800@tmr.com>	 <1100187716.5358.5.camel@localhost> <1100193219.5358.25.camel@localhost>
In-Reply-To: <1100193219.5358.25.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2004 17:19:31.0981 (UTC) FILETIME=[9BAA43D0:01C4C812]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>The closest you can come to normal I/O without the page cache is by
>doing posix_fadvise() to prune your cache pages after you touch them.
>  
>
Or you can use aio with O_DIRECT.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

