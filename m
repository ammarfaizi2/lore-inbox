Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSHCAtE>; Fri, 2 Aug 2002 20:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSHCAtE>; Fri, 2 Aug 2002 20:49:04 -0400
Received: from holomorphy.com ([66.224.33.161]:4804 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317365AbSHCAtD>;
	Fri, 2 Aug 2002 20:49:03 -0400
Date: Fri, 2 Aug 2002 17:52:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
Message-ID: <20020803005205.GK25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
References: <3D4AE995.DFD862EF@zip.com.au> <Pine.LNX.4.44L.0208022113440.23404-100000@imladris.surriel.com> <3D4B2471.29EE6462@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D4B2471.29EE6462@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>> Remember that we're planning to go to an object-based scheme
>> later on, turning the code into a big monolithic mesh really
>> makes long-term maintenance a pain...

On Fri, Aug 02, 2002 at 05:31:45PM -0700, Andrew Morton wrote:
> We have short-term rmap problems:
> 1) Unexplained pte chain state with ntpd
> 2) 10-20% increased CPU load in fork/exec/exit loads
> 3) system lock under heavy mmap load
> 4) ZONE_NORMAL pte_chain consumption

On Fri, Aug 02, 2002 at 05:31:45PM -0700, Andrew Morton wrote:
> Daniel and I are on 2), Bill is on 4) (I think).

I am indeed on (4), though I'd describe what I'm doing as "OOM handling".





Cheers,
Bill
