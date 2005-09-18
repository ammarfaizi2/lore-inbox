Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVIRDGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVIRDGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 23:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVIRDGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 23:06:18 -0400
Received: from [216.132.251.226] ([216.132.251.226]:39611 "EHLO
	mwg.inxservices.lan") by vger.kernel.org with ESMTP
	id S1751282AbVIRDGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 23:06:18 -0400
Date: Sat, 17 Sep 2005 20:06:17 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050918030617.GE10635@inxservices.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <432AFB44.9060707@namesys.com> <200509171416.21047.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509171416.21047.vda@ilport.com.ua>
Organization: inX Services, Los Angeles, CA, USA
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 02:16:20PM +0300, Denis Vlasenko wrote:
> Random observation:
> 
> You can declare functions even if you never use them.
> Thus here you can avoid using #if/#endif:
> 
> #if defined(REISER4_DEBUG) || defined(REISER4_DEBUG_MODIFY) || defined(REISER4_DEBUG_OUTPUT)
> int znode_is_loaded(const znode * node /* znode to query */ );
> #endif

   What is wrong with documentation, in your opinion?
