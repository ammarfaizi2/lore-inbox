Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWFZRjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFZRjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWFZRjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:39:09 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:23994 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751207AbWFZRjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZnZ0Ah9dnyRYTI6NIzKuSw9CcnwWvEriD2ikQVZp1Tm52QCleG5ZjoqhgCfiunADeOA8qS58o97OuDYwWDV/WD5qyBCsyGV4aczU6KCmf0cfxm1FwQHCUsubfkq8u9y2TRy3qgMmrLImwviygILVXe27g+bVCjy1kSUU2vJYnD0=  ;
Message-ID: <44A01BBB.3070903@yahoo.com.au>
Date: Tue, 27 Jun 2006 03:39:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Peterson" <dsp@llnl.gov>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [rfc][patch] fixes for several oom killer problems
References: <20060626162038.GB7573@wotan.suse.de>
In-Reply-To: <20060626162038.GB7573@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hi,
> 
> We have reports of OOM killer panicing the system even if there are
> tasks currently exiting and/or plenty able to be freed.
> 

BTW, I should credit Jan Beulich with spotting some of the issues
and helping to debug the problem.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
