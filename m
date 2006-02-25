Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWBYHz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWBYHz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWBYHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:55:58 -0500
Received: from ozlabs.org ([203.10.76.45]:64904 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932445AbWBYHz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:55:57 -0500
Subject: Re: 2.6.16-rc4-mm2: drivers/isdn/hysdn/hysdn_net.c module_param()
	compile error
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <20060224232222.73803498.akpm@osdl.org>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	 <20060225033855.GG3674@stusta.de>  <20060224232222.73803498.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 18:56:03 +1100
Message-Id: <1140854163.10212.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 23:22 -0800, Andrew Morton wrote:
> Bad Rusty should have chosen less generic-sounding identifiers.

I actually disagree with that, for three reasons.  Firstly, my namespace
didn't leak: I only appended these names to clear prefixes.  Secondly,
uint is already typedefed in types.h.  Thirdly, the short names are
clear and intuitive.

> Bad ISDN shouldn't have gone off and defined its own types, either.

That was poor, yes, but typedefs would have been less polluting than
#defines.

Hope that clarifies!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

