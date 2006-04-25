Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWDYWkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWDYWkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWDYWkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:40:05 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:43999 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751633AbWDYWkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:40:04 -0400
Message-ID: <444EA53F.20609@acm.org>
Date: Tue, 25 Apr 2006 17:39:59 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gross, Mark" <mark.gross@intel.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <5389061B65D50446B1783B97DFDB392DA97799@orsmsx411.amr.corp.intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA97799@orsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gross, Mark wrote:

>>
>>    
>>
>
>Done. 
>Signed-off-by: Mark Gross
>
>
>--mgross
>  
>
Yes, this is what I was talking about.  I believe the mode of
module_param should be 444, since modifying this after the module is
loaded won't do anything.  Also, it might be nice to print something
different in the "force" case.

Thanks,

-Corey
