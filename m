Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJOBSG>; Mon, 14 Oct 2002 21:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262676AbSJOBSG>; Mon, 14 Oct 2002 21:18:06 -0400
Received: from holomorphy.com ([66.224.33.161]:5267 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262670AbSJOBSF>;
	Mon, 14 Oct 2002 21:18:05 -0400
Date: Mon, 14 Oct 2002 18:20:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: john stultz <johnstul@us.ibm.com>, Matt <colpatch@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <20021015012015.GN4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	john stultz <johnstul@us.ibm.com>, Matt <colpatch@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	LSE Tech <lse-tech@lists.sourceforge.net>,
	Andrew Morton <akpm@zip.com.au>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <1034643354.19094.149.camel@cog> <2007503407.1034618934@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2007503407.1034618934@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, jstultz wrote:
>> Just an FYI: I believe the x440 breaks this assumption. 
>> There are 2 chunks on the first CEC. The current discontig patch for it
>> has to drop the second chunk (anything over 3.5G on the first CEC) in
>> order to work w/ the existing code. However, that will probably need to
>> be addressed at some point, so be aware that this might affect you as
>> well. 

On Mon, Oct 14, 2002 at 06:08:56PM -0700, Martin J. Bligh wrote:
> No, the NUMA code in the kernel doesn't support that anyway.
> You have to use zholes_size, and waste some struct pages,
> or config_nonlinear. Either way you get 1 memblk.

I thought zholes stuff freed the struct pages. Maybe that was done
by hand.


Bill
