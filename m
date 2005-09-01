Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVIAHXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVIAHXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVIAHXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:23:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20964 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965059AbVIAHXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:23:52 -0400
Date: Thu, 1 Sep 2005 12:53:03 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Message-ID: <20050901072303.GB9760@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200509010829.35958.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509010829.35958.thomas.schlichter@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 08:29:32AM +0200, Thomas Schlichter wrote:
> I tested the attached patch during the last night and it sems to work...

A quick feedback on your patch:

A litmus test that I use is if "zero" lost ticks are being hit, 
which we should not w/o a patch like dynamic tick.

I still see zero lost ticks being reported with your patch (during
bootup atleast) which means all is still not well?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
