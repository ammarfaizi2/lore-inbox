Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWDZCTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWDZCTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWDZCTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:19:11 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:45964 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932346AbWDZCTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:19:11 -0400
Message-ID: <444ED89D.8020405@acm.org>
Date: Tue, 25 Apr 2006 21:19:09 -0500
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
References: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gross, Mark wrote:

>>Yes, this is what I was talking about.  I believe the mode of
>>module_param should be 444, since modifying this after the module is
>>loaded won't do anything.  Also, it might be nice to print something
>>different in the "force" case.
>>    
>>
>
>How about printing nothing like it used too?
>
>See attached.  
>  
>
This is fine with me.  I debated between printing nothing and a "You
have chosen to override ..." print but didn't come out with any
opinion.  I'm easy either way.

The indenting in the "if (!force_function_unhide && !(stat8 & (1 << 5)))
{" clause is kind of strange and you have some spaces instead of tabs
right after that (where stat8 is set).

Thanks again,

-Corey
