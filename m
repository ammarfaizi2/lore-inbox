Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFNJx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFNJx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFNJx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:53:26 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:53899 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261159AbVFNJxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:53:22 -0400
Message-ID: <42AEA90A.4010004@yahoo.com.au>
Date: Tue, 14 Jun 2005 19:53:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: yang.yi@bmrtech.com
CC: LKML <linux-kernel@vger.kernel.org>,
       China Performance Team <china-perf@mvista.com>
Subject: Re: 2.6 kernel series have noticeable performance regression, URLs
References: <1118739967.10339.1571.camel@montavista2>
In-Reply-To: <1118739967.10339.1571.camel@montavista2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yangyi wrote:
> Hi, all
> 
> Because of format problem, the previous articles are very hard to read,
> now, I can provide a ftp server for downloading those test results.
> Please use gedit to read it.
> 

fork/exec/sh regressions will be mostly due to the unfortunate
4level page tables regressions which have been fixed after 2.6.11.

Also, on the SMP machine, you should bind the entire lmbench test
to just one of the CPUs, because changes to SMP balancing can have
disproportionate or unrealistic changes.

It would be good if you could compare again with the latest 2.6.12
-git release.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
