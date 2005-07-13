Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVGMVir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVGMVir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVGMVif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:38:35 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37087 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262607AbVGMViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:38:19 -0400
Message-ID: <42D5897D.2030000@nortel.com>
Date: Wed, 13 Jul 2005 15:37:01 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>	 <42D540C2.9060201@tmr.com>	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>	 <20050713184227.GB2072@ucw.cz>	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>	 <1121282025.4435.70.camel@mindpipe>	 <d120d50005071312322b5d4bff@mail.gmail.com>	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>	 <20050713211650.GA12127@taniwha.stupidest.org> <1121289881.4435.102.camel@mindpipe>
In-Reply-To: <1121289881.4435.102.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Does anyone object to setting HZ at boot?  I suspect nothing else will
> make everyone happy.

Makes it harder to optimize the conversions, doesn't it?  Knowing the HZ 
value at compile-time would allow the compiler to do it's thing better 
in some cases.

Chris
