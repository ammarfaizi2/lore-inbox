Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWIYU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWIYU7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWIYU7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:59:04 -0400
Received: from gw.goop.org ([64.81.55.164]:9628 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751177AbWIYU7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:59:02 -0400
Message-ID: <45184318.6060807@goop.org>
Date: Mon, 25 Sep 2006 13:59:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
Subject: Re: [PATCH 1/6] Initialize the per-CPU data area.
References: <20060925184540.601971833@goop.org> <20060925184638.385115998@goop.org> <200609252249.54901.ak@suse.de>
In-Reply-To: <200609252249.54901.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> If this is really 1/1 why does it patch a file called pda.h? 
>
> I've thrown away the local pda patches before this because I assumed
> you started fresh.
>
> Somehow I'm not surprised that nothing applies.  You seem to always
> start with some random tree that nobody else has.
>   
Well, it's based on -mm, but I guess that includes pieces of your patch 
series.  I was a bit surprised to see pda.h still in -mm with the rest 
dropped.

> Anyways, this patchkit has caused so much trouble and churn that I'll drop
> it for now until after the .19 merge is done.
>   
I'll respin it against your patches later today.

    J
