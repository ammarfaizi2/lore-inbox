Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUDSQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUDSQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:43:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38557 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261416AbUDSQmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:42:49 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: john stultz <johnstul@us.ibm.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Niclas Gustafsson <niclas.gustafsson@codesense.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0404151633100.17365@jurand.ds.pg.gda.pl>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
	 <1081932857.17234.37.camel@gmg.codesense.com>
	 <Pine.LNX.4.55.0404151633100.17365@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1082392850.10026.13.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Apr 2004 09:40:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 07:47, Maciej W. Rozycki wrote:
>  This may be because buggy SMM firmware messes with the 8259A (configured
> for a transparent mode -- yes that rare "local-APIC-edge" mode is tricky
> ;-) ) insanely.  You've written this is an IBM box previously -- this 
> would be no surprise.  The following patch should help -- I think it's 
> already included in the -mm series.

Just a FYI: I opened bugme bug #2544 to track this issue. 
http://bugme.osdl.org/show_bug.cgi?id=2544

thanks
-john

