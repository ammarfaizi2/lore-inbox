Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUFOAfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUFOAfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 20:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUFOAfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 20:35:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264904AbUFOAfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 20:35:10 -0400
Date: Mon, 14 Jun 2004 21:27:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
Message-ID: <20040615002734.GA9801@logos.cnet>
References: <200404091311.50787@zigzag.lvk.cs.msu.su> <20040413131017.GA11294@logos.cnet> <Pine.LNX.4.60.0406140959250.30433@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406140959250.30433@dlang.diginsite.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:01:53AM -0700, David Lang wrote:
> I think I may be running into the same (or a similar) issue with a 
> workload that forks heavily (~3500 forks/sec). What can I do to let the 
> system survive this sort of load? 

Hi David,

v2.6.7-mm tree contains a fix for this, adding a rlimit for
pending signals.

Can you describe the problem you are seeing in more detail?


