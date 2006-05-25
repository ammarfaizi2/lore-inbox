Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWEYS7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWEYS7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWEYS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:59:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:54493 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030344AbWEYS7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:59:33 -0400
Date: Thu, 25 May 2006 20:59:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
In-Reply-To: <4475FD12.2030300@pardus.org.tr>
Message-ID: <Pine.LNX.4.61.0605252056440.13379@yvahk01.tjqt.qr>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
 <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <4475FD12.2030300@pardus.org.tr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > # hostname --fqdn
>> > shanghai.hopto.org
>> 
>> Ahh. I wonder how portable this is. We could certainly make the kernel
>> build use "hostname --fqdn" if that works across all versions.
>> 
>> That code hasn't changed in a looong time, and I suspect that "--fqdn"
>> didn't exist back when.. 
>
> Doesn't work here :
>
> cartman@southpark ~ $ hostname --fqdn
> hostname: invalid option -- -
> Try `hostname --help' for more information.
> cartman@southpark ~ $ hostname --version
> hostname (GNU coreutils) 5.96

20:56 shanghai:~ > hostname --version
net-tools 1.60
hostname 1.100 (2001-04-14)

Interesting.


Jan Engelhardt
-- 
