Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWIZRkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWIZRkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIZRkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:40:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:43074 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932175AbWIZRkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:40:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,221,1157353200"; 
   d="scan'208"; a="137733643:sNHT1369782953"
Message-ID: <4519656B.8060309@intel.com>
Date: Tue, 26 Sep 2006 10:37:47 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore __iomem annotations in e1000
References: <20060923003240.GF29920@ftp.linux.org.uk> <45186F87.8080207@pobox.com> <4518B451.4080303@intel.com> <4518BB6E.5010005@pobox.com>
In-Reply-To: <4518BB6E.5010005@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2006 17:39:47.0900 (UTC) FILETIME=[C2F5C7C0:01C6E192]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Auke Kok wrote:
>> Jeff Garzik wrote:
>>> applied
>>>
>>
>> Thanks,
>>
>> I have no idea why and when these annotations were lost, but we have 
>> them in much older versions of the code. I'll try to track it down and 
>> make sure that it doesn't disappear again.
> 
> Just run an sparse check as described in
> Documentation/sparse.txt...

gotcha, I'll try to do this on a regular basis.

Thanks,

Auke
