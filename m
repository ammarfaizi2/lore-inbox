Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUHFIeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUHFIeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUHFIeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:34:23 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:29957 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268101AbUHFIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:30:29 -0400
Message-ID: <41134272.3080902@hist.no>
Date: Fri, 06 Aug 2004 10:33:54 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andy Isaacson <adi@hexapodia.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet> <20040806020930.GA23072@hexapodia.org> <20040806022734.GN17188@holomorphy.com>
In-Reply-To: <20040806022734.GN17188@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>At some point in the past, I wrote:
>
>>-r+ -d:KEY: > key-bk$X" when it creates the tarball.  Then anyone can
>>"bk clone -r`cat key-bk7` linux-2.5 linux-2.6-bk7" and duplicate the
>>-bk7 state of the tree, and then "bk changes -L ../linux-2.6-bk6" to
>>find the list of changesets differing.
>>    
>>
>
>Once we get there, there must be some way to construct intermediate
>points between those two faithful at the very least to the snapshot
>ordering if not true chronological ordering.
>  
>
You don't really need chronology for a binary search.  With a
list of changesets, just apply/back out half of them.  Divide the lot
any way you like, perhaps starting with only the "suspected" ones.

Helge Hafting
