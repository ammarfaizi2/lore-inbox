Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313236AbSDTXaf>; Sat, 20 Apr 2002 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSDTXae>; Sat, 20 Apr 2002 19:30:34 -0400
Received: from holomorphy.com ([66.224.33.161]:1703 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313236AbSDTXad>;
	Sat, 20 Apr 2002 19:30:33 -0400
Date: Sat, 20 Apr 2002 16:29:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lse-tech@lists.sourceforge.net, Martin.Bligh@us.ibm.com
Subject: Re: [PATCH] rmap 13
Message-ID: <20020420232938.GH21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lse-tech@lists.sourceforge.net,
	Martin.Bligh@us.ibm.com
In-Reply-To: <Pine.LNX.4.44L.0204201731220.1960-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 05:32:19PM -0300, Rik van Riel wrote:
> Better SMP scalability, first batch of lock breakup work. Still
> experimental, but testing is very much welcome...
...
[general comments]
> My big TODO items for a next release are:
>   - O(1) page launder - currently functional but slow, needs to be tuned
>   - pte-highmem

If I can clarify a bit, I'm deferring submission of the subsequent bits
of the lock breakups in order to to expose the various stages of it to
wider testing individually. One can't be too careful with these changes.

Also, Martin Bligh is the original author of the per-page pte_chain
locking patch.


More to come,
Bill
