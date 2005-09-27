Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVI0QRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVI0QRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVI0QRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:17:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1755 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964928AbVI0QRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:17:50 -0400
Message-ID: <433970A9.6010409@austin.ibm.com>
Date: Tue, 27 Sep 2005 11:17:45 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 7/9] try harder on large allocations
References: <4338537E.8070603@austin.ibm.com> <433856B2.8030906@austin.ibm.com> <2cd57c90050927002163f78269@mail.gmail.com>
In-Reply-To: <2cd57c90050927002163f78269@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>+               if (order < MAX_ORDER/2) out_of_memory(gfp_mask, order);
> 
> 
> Shouldn't that be written in two lines?

Yes, fixed.
