Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVASVoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVASVoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVASVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:43:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:20390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbVASVkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:40:40 -0500
Date: Wed, 19 Jan 2005 13:39:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: stevel@mvista.com, ak@suse.de, hugh@veritas.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: BUG in shared_policy_replace() ?
Message-Id: <20050119133953.667630f5.akpm@osdl.org>
In-Reply-To: <20050119192955.GC26170@wotan.suse.de>
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain>
	<41EE9991.6090606@mvista.com>
	<20050119174506.GH7445@wotan.suse.de>
	<41EEA575.9040007@mvista.com>
	<20050119183430.GK7445@wotan.suse.de>
	<41EEAE04.3050505@mvista.com>
	<20050119190927.GM7445@wotan.suse.de>
	<41EEB440.8010108@mvista.com>
	<20050119192955.GC26170@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  > -				new2 = NULL;
> 
>  Ah, I agree. Yes, it looks like a merging error when merging
>  with Hugh's changes. Thanks for catching this.
> 
>  The line should not be removed. Andrew should I submit a new patch or can 
>  you just fix it up?

I'll fix it up, thanks.
