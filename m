Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSKNTsu>; Thu, 14 Nov 2002 14:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSKNTsu>; Thu, 14 Nov 2002 14:48:50 -0500
Received: from ns.suse.de ([213.95.15.193]:773 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265192AbSKNTst>;
	Thu, 14 Nov 2002 14:48:49 -0500
Date: Thu, 14 Nov 2002 20:55:43 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
Message-ID: <20021114205543.A9383@wotan.suse.de>
References: <3DD3FCB3.40506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD3FCB3.40506@us.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 11:42:43AM -0800, Dave Hansen wrote:
> I copied the x86_64 early printk support for plain x86.  Is anyone 
> opposed to me sending this on to Linus?

No problem from my side.

although it may make sense to just put in the #ifdef __i386__ for vgabase
and then #include it.

-Andi
