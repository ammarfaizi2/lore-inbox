Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUANJlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUANJjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:39:08 -0500
Received: from colin2.muc.de ([193.149.48.15]:22789 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265578AbUANJio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:38:44 -0500
Date: 14 Jan 2004 10:39:40 +0100
Date: Wed, 14 Jan 2004 10:39:40 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114093940.GC19652@colin2.muc.de>
References: <20040114090603.GA1935@averell> <1074072899.4981.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074072899.4981.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 10:34:59AM +0100, Arjan van de Ven wrote:
> On Wed, 2004-01-14 at 10:06, Andi Kleen wrote:
> 
> > 
> > According to some gcc developers it should be safe to use in all
> > gccs that are still supports (2.95 and up) 
> 
> it is not safe for the kernel until the cardbus CardServices patches get
> merged (is in -mm), for the same reason CardServices() is broken on
> amd64.

Just mark them asmlinkage then.

I would be a shame to leave that much space saving on the table just
for an single misdesigned API than can be easily fixed.

-Andi
