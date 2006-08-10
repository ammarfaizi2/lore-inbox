Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWHJSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWHJSGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWHJSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:06:21 -0400
Received: from gw.goop.org ([64.81.55.164]:39816 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1422676AbWHJSGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:06:20 -0400
Message-ID: <44DB7596.6010503@goop.org>
Date: Thu, 10 Aug 2006 11:06:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>
In-Reply-To: <1155202505.18420.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> +EXPORT_SYMBOL_GPL(paravirt_ops);
>   
This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
driver module will need to be GPL...

    J
