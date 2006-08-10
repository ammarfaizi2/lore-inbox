Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWHJPO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWHJPO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHJPO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:14:26 -0400
Received: from gw.goop.org ([64.81.55.164]:200 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751382AbWHJPOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:14:25 -0400
Message-ID: <44DB4D58.9010105@goop.org>
Date: Thu, 10 Aug 2006 08:14:32 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>	<1155204603.18420.9.camel@localhost.localdomain>	<20060810103012.GA2356@muc.de> <1155207946.18420.18.camel@localhost.localdomain>
In-Reply-To: <1155207946.18420.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> OK, they're all static fns except two: I changed to "native".  Since
> they're in paravirt.c it's pretty clear what they're for.  Compiled and
> booted.
>   

More will become un-static later on.  "native_" seems a little generic 
to me, but I can live with it.

    J
