Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132755AbRC2PsW>; Thu, 29 Mar 2001 10:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRC2PsM>; Thu, 29 Mar 2001 10:48:12 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:50421 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132755AbRC2PsF>; Thu, 29 Mar 2001 10:48:05 -0500
Date: Thu, 29 Mar 2001 10:47:10 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Message-ID: <20010329104710.A18159@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01032910124007.00454@neo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032910124007.00454@neo>; from k@ailis.de on Thu, Mar 29, 2001 at 10:12:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Reimer (k@ailis.de) said: 
> 2001-03-29 10:02:50.054774500 {kern|info} kernel: ad1848/cs4248 codec driver 
> Copyright (C) by Hannu Savolainen 1993-1996
> 2001-03-29 10:02:50.070692500 {kern|notice} kernel: opl3sa2: No cards found
> 2001-03-29 10:02:50.070703500 {kern|notice} kernel: opl3sa2: 0 PnP card(s) 
> found.

Add 'isapnp=0' to the end of the options in your modules.conf.
I *believe* this is fixed in a later kernel (2.4.3pre or 2.4.2ac).

Bill
