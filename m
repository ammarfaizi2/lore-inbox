Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWEYSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWEYSrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWEYSrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:47:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030327AbWEYSrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:47:47 -0400
Date: Thu, 25 May 2006 11:47:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
 <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 May 2006, Jan Engelhardt wrote:
>
> # hostname --fqdn
> shanghai.hopto.org

Ahh. I wonder how portable this is. We could certainly make the kernel 
build use "hostname --fqdn" if that works across all versions.

That code hasn't changed in a looong time, and I suspect that "--fqdn" 
didn't exist back when.. 

		Linus
