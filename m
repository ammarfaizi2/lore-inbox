Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSFTINM>; Thu, 20 Jun 2002 04:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSFTINL>; Thu, 20 Jun 2002 04:13:11 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:48389 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311749AbSFTINK>; Thu, 20 Jun 2002 04:13:10 -0400
Date: Thu, 20 Jun 2002 09:13:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rml@tech9.net, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
Message-ID: <20020620091306.B6313@flint.arm.linux.org.uk>
References: <3D11245F.DB13A07C@mvista.com> <20020619.183432.27032473.davem@redhat.com> <1024538005.922.70.camel@sinai> <20020619.185514.52961715.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020619.185514.52961715.davem@redhat.com>; from davem@redhat.com on Wed, Jun 19, 2002 at 06:55:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 06:55:14PM -0700, David S. Miller wrote:
> Also, when people remove *_BH they should remove the define in
> include/linux/interrupt.h Why people leave this there is beyond me, it
> only causes confusion when people try to figure out what the current
> state of affairs is.

Missed this bit 8/

iirc willy also covered this in one of his postings to lkml, might even
have been the serial bh one.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

