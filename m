Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUE2ILp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUE2ILp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUE2ILp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:11:45 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16004 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264019AbUE2ILn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:11:43 -0400
Date: Sat, 29 May 2004 10:12:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: FabF <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.6-mm2] i8042 debug broken
Message-ID: <20040529081202.GA1269@ucw.cz>
References: <1084532991.8303.2.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084532991.8303.2.camel@bluerhyme.real3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 01:09:51PM +0200, FabF wrote:
> Hi,
> 
> 	i8042 handle_data debug was broken -trying to display unknown
> irq-.Here's a quick fix.

I reverted the tasklet conversion of i8042. It should be OK now. And
also you shouldn't have a dead keyboard after you press CapsLock. 
That was likely what your cat did.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
