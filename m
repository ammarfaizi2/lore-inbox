Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265664AbSKAI2X>; Fri, 1 Nov 2002 03:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265665AbSKAI2W>; Fri, 1 Nov 2002 03:28:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56580 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265664AbSKAI2W>;
	Fri, 1 Nov 2002 03:28:22 -0500
Date: Fri, 1 Nov 2002 00:31:47 -0800
From: Greg KH <greg@kroah.com>
To: "Paulo Andre'" <fscked@netvisao.pt>
Cc: linux-kernel@vger.kernel.org, jgarzik@redhat.com, alan@redhat.com,
       Philip.Blundell@pobox.com
Subject: Re: [PATCH] Make 3c505.c use spinlocks instead of cli/sti
Message-ID: <20021101083147.GB14568@kroah.com>
References: <20021031021558.38763ed7.fscked@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031021558.38763ed7.fscked@netvisao.pt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:15:58AM +0000, Paulo Andre' wrote:
> Hi,
> 
> This patch does some cleanup on the 3c505.c driver by making use of
> spinlocks instead of the deprecated cli()/sti() scheme. Note that even
> though it compiles fine, I don't have the specific hardware to test
> this.
> 
> Patch is against 2.5.45.

The patch looks sane at first glance.  I think I have one of these cards
around at work, and if I find it I'll try this patch out tomorrow.

thanks,

greg k-h
