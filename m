Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVKKBAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVKKBAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVKKBAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:00:49 -0500
Received: from holomorphy.com ([66.93.40.71]:51383 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932297AbVKKBAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:00:48 -0500
Date: Thu, 10 Nov 2005 16:51:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: [PATCH] dequeue a huge page near to this node
Message-ID: <20051111005119.GQ29402@holomorphy.com>
References: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 03:27:12PM -0800, Christoph Lameter wrote:
> The following patch changes the dequeueing to select a huge page near
> the node executing instead of always beginning to check for free 
> nodes from node 0. This will result in a placement of the huge pages near
> the executing processor improving performance.
> The existing implementation can place the huge pages far away from 
> the executing processor causing significant degradation of performance.
> The search starting from zero also means that the lower zones quickly 
> run out of memory. Selecting a huge page near the process distributed the 
> huge pages better.
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Long intended to have been corrected. Thanks.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
