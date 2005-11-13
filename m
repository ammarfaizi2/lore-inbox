Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVKMUNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKMUNU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 15:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVKMUNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 15:13:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57305 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750734AbVKMUNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 15:13:20 -0500
Date: Sun, 13 Nov 2005 12:13:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia64 SN2 - migration costs: 1) nearly zero 2) BUG 3) repeated
Message-Id: <20051113121309.226543ca.pj@sgi.com>
In-Reply-To: <20051113071716.GA31075@elte.hu>
References: <20051112135410.3eef5641.pj@sgi.com>
	<20051112144949.3b331aa1.pj@sgi.com>
	<20051113071716.GA31075@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> Could you try 
> migration_debug=3 with the .config that failed before? (if it doesnt 
> fail, could you re-check it still fails with migration_debug=2?) 

I've tried these two, and with no migration_debug, as close as I
could remember to the original case with the bad (zeros) table.

It never failed again.

Gremlins, I tell you.  Gremlins.

Looks like the "BUG: using smp_processor_id() in preemptible"
is the only actionable item in my report.  Sorry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
