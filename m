Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWEYQsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWEYQsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWEYQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:48:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030273AbWEYQsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:48:45 -0400
Date: Thu, 25 May 2006 09:48:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 May 2006, Jan Engelhardt wrote:
> 
> As for extending the linux_banner, here's a real patch in my line...

No, this sucks.

Sane configurations already have the FQDN as the hostname. It's quite 
common to have "hostname" be the full name, and domainname be "(none)" 
(with dnsdomainname being the domain name).

I think your patch would make it say

	torvalds@g5.osdl.org.osdl.org

for me.

So just fix your hostname to give the full hostname. Nothing less makes 
any sense anyway.

		Linus
