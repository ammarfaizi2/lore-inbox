Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266649AbUAWTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUAWTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:15:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49137 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266649AbUAWTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:15:16 -0500
Date: Fri, 23 Jan 2004 20:15:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc1-mm2
Message-ID: <20040123191509.GT6441@fs.tum.de>
References: <1074870538.5122.9.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074870538.5122.9.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 04:08:58PM +0100, Jan Ischebeck wrote:

>...
> Only the radeon dri driver cannot be inserted because of an missing
> symbol: 
> radeon: Unknown symbol cmpxchg

This is a known problem if your .config includes support for the 386
cpu.

Unselect

  Processor type and features
    Processor support
      386

and recompile your kernel.

> Thx for the frequent releases,
> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

