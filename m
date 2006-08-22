Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWHVM4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHVM4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHVM4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:56:06 -0400
Received: from gw.goop.org ([64.81.55.164]:36067 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751294AbWHVM4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:56:05 -0400
Message-ID: <44EAFEE3.8080700@goop.org>
Date: Tue, 22 Aug 2006 05:56:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de> <44E67B6E.10706@goop.org> <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
>> relicensing them.
>>     
>
> That's a pretty strong statement...
>   

Well, I'm not making any kind of legal statement.  I'm just pointing out 
that from a technical perspective, there's a large visible functional 
change from before if we use EXPORT_SYMBOL_GPL(paravirt_ops) vs 
EXPORT_SYMBOL(paravirt_ops).  Given that the whole point of paravirt_ops 
is to minimize visible changes, this seems counterproductive.

    J
