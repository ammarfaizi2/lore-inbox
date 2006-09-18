Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWIRHwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWIRHwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbWIRHwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:52:24 -0400
Received: from ns.suse.de ([195.135.220.2]:4568 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751569AbWIRHwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:52:24 -0400
To: "Bharath Ramesh" <krosswindz@gmail.com>
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       rlpowell@digitalkingdom.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
References: <20060912223258.GM4612@chain.digitalkingdom.org>
	<20060914190548.GI4610@chain.digitalkingdom.org>
	<1158261249.7948.111.camel@mindpipe>
	<20060914191555.GJ4610@chain.digitalkingdom.org>
	<c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 09:52:18 +0200
In-Reply-To: <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com>
Message-ID: <p737j01628d.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bharath Ramesh" <krosswindz@gmail.com> writes:

> Have you tried booting newer kernel post 2.6.13 with the boot option
> mce=bootlog and see if it goes past the current failure. Try the same
> with with noacpi.

Did you mean mce=off? mce=bootlog will just log the leftover MCEs 
from the previous boot, but that shouldn't change anything.

-Andi
