Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVGEBUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVGEBUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 21:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGEBUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 21:20:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19124 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261746AbVGEBUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 21:20:01 -0400
Date: Tue, 5 Jul 2005 02:21:41 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: REGRESSION in 2.6.13-rc1: Massive slowdown with Adaptec SCSI
Message-ID: <20050705012141.GB9312@parcelfarce.linux.theplanet.co.uk>
References: <17097.56705.490622.759154@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17097.56705.490622.759154@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 11:08:17AM +1000, Neil Brown wrote:
>  On 2.6.13-rc1 the same test takes just short on 1 minute and reports
>  slightly less than 2 M/Second.

That sounds like your drives have negotiated an asynchronous transfer
agreement.  Could you provide your dmesg to confirm that diagnosis?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
