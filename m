Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTHFSLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTHFSLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:11:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59814 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270811AbTHFSLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:11:31 -0400
Subject: Re: [RFC][PATCH] linux-2.6.0-test2_mtrr-race-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1060193108.12048.4.camel@markh1.pdx.osdl.net>
References: <200308061052.18550.Mathias.Froehlich@web.de>
	 <1060190104.10732.52.camel@cog.beaverton.ibm.com>
	 <1060193108.12048.4.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1060192965.10732.58.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2003 11:02:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 11:05, Mark Haverkamp wrote:
> On Wed, 2003-08-06 at 10:15, john stultz wrote:
> > 
> > Well, let me look at it again and see if I can come up with a proper
> > fix. 
> I added an extra sync up from the caller after the last gate change so
> it is the last one to touch the automatic data.

Ah, you beat me to it! 

I'm actually testing the very same change (comments differ a touch, but
that's ok).

Looks good. If everyone is happy I'd say resubmit it to Andrew.

thanks
-john



