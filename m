Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbSLLCEt>; Wed, 11 Dec 2002 21:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbSLLCEt>; Wed, 11 Dec 2002 21:04:49 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:19450 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267406AbSLLCEs>; Wed, 11 Dec 2002 21:04:48 -0500
Date: Wed, 11 Dec 2002 18:11:44 -0800
From: Chris Wright <chris@wirex.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capable open_port() check wrong for kmem
Message-ID: <20021211181144.B26790@figure1.int.wirex.com>
Mail-Followup-To: carbonated beverage <ramune@net-ronin.org>,
	linux-kernel@vger.kernel.org
References: <20021210032242.GA17583@net-ronin.org> <at3v15$mur$1@abraham.cs.berkeley.edu> <20021210064134.GA17928@net-ronin.org> <20021210065159.GB17928@net-ronin.org> <20021211164348.A26790@figure1.int.wirex.com> <20021212013849.GA24054@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021212013849.GA24054@net-ronin.org>; from ramune@net-ronin.org on Wed, Dec 11, 2002 at 05:38:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* carbonated beverage (ramune@net-ronin.org) wrote:
> 
> So if I want to have a generic utility that can be used by any user (and
> I'm not granting CAP_SYS_RAWIO to every process), then I can:
> 
> 1) make it suid root
> 2) drop all caps other than cap_sys_rawio
> 
> or
> 
> 1) add the capability to the executable, assuming it worked...

this is not supported without kernel patches.  in general you have to
start with full capabilities and shed the ones you don't need.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
