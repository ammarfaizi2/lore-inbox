Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUANJci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUANJch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:32:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:17590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265568AbUANJ3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:29:08 -0500
Date: Wed, 14 Jan 2004 01:29:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-Id: <20040114012928.1e90af3b.akpm@osdl.org>
In-Reply-To: <20040114090603.GA1935@averell>
References: <20040114090603.GA1935@averell>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
>  I didn't make it the default because it will break all binary only
>  modules (although they can be fixed by adding a wrapper that 
>  calls them with "asmlinkage"). Actually it may be a good idea to 
>  make this default with 2.7.1 or somesuch.

yes, that is a hassle.  But for these sorts of gains, it's worth pursuing
it a bit further.

How _much_ of a hassle it will be I can not say - I'd be looking to vendors
to advise before merging this into mainline.

I changed your patch to make it dependent on CONFIG_EXPERIMENTAL.

