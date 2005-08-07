Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752277AbVHGQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbVHGQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbVHGQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:26:12 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24201 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1752273AbVHGQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:26:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>, bunk@stusta.de
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Date: Sun, 7 Aug 2005 19:25:52 +0300
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050731222606.GL3608@stusta.de> <20050731.153631.70217457.davem@davemloft.net>
In-Reply-To: <20050731.153631.70217457.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508071925.52221.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 August 2005 01:36, David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Mon, 1 Aug 2005 00:26:07 +0200
> 
> > - my impression is that the older compilers are only rarely
> >   used, so miscompilations of a driver with an old gcc might
> >   not be detected for a longer amount of time
> 
> Many people still use 2.95 because it's still the fastest
> way to get a kernel build done and that's important for
> many people.
> 
> And with 4.0 being a scary regression in the compile time
> performance area compared to 3.4, this becomes even more
> important to keep around.

This is a rather strange form of "progress", especially
since in my experience newer gcc's do not show significant
reductions in code size...
--
vda

