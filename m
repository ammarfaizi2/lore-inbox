Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSFTQLk>; Thu, 20 Jun 2002 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSFTQLj>; Thu, 20 Jun 2002 12:11:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64705 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315204AbSFTQLi>;
	Thu, 20 Jun 2002 12:11:38 -0400
Message-ID: <3D11FE5F.8000207@us.ibm.com>
Date: Thu, 20 Jun 2002 09:10:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gross, Mark" <mark.gross@intel.com>
CC: "'Russell Leighton'" <russ@elegant-software.com>,
       Andrew Morton <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles
 gets large
References: <59885C5E3098D511AD690002A5072D3C057B499E@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gross, Mark wrote:
> We will get around to reformatting our spindles to some other FS after 
> we get as much data and analysis out of our current configuration as we 
> can get. 
>  
> We'll report out our findings on the lock contention, and throughput 
> data for some other FS then.  I'd like recommendations on what file 
> systems to try, besides ext2.

Do you really need a journaling FS?  If not, I think ext2 is a sure 
bet to be the fastest.  If you do need journaling, try reiserfs and jfs.

BTW, what kind of workload are you running under?

-- 
Dave Hansen
haveblue@us.ibm.com

