Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVESP0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVESP0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVESP0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:26:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58801 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262526AbVESPZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:25:44 -0400
Message-ID: <428CAFEA.6040909@pobox.com>
Date: Thu, 19 May 2005 11:25:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Daniel Phillips <phillips@istop.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
References: <20050518223303.GE1340@ca-server1.us.oracle.com>	 <200505190230.23624.phillips@istop.com>  <428C69EA.6080001@pobox.com> <1116516008.21685.25.camel@mindpipe>
In-Reply-To: <1116516008.21685.25.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-05-19 at 06:26 -0400, Jeff Garzik wrote:
> 
>>Daniel Phillips wrote:
>>
>>>Zero terminated strings for lock names is bad taste.  It generates a bunch of 
>>>useless strlen executions and you force an ascii namespace for no apparent 
>>>reason.  Add a 9th parameter, namelen, to the lock call maybe?
>>
>>What's wrong with ascii strings?
>>
>>We call those 'UTF8' these days.
> 
> 
> I think you just answered your own question.

Incorrect.  Read the quoted context.

	Jeff



