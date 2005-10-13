Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVJMO2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVJMO2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 10:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVJMO2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 10:28:18 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:32934 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750823AbVJMO2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 10:28:18 -0400
Date: Thu, 13 Oct 2005 08:28:09 -0600
From: Troy Heber <troy.heber@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051013142807.GI21984@me.troyhebe>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	OBATA Noboru <noboru.obata.ar@hitachi.com>,
	hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com> <20051006.211718.74749573.noboru.obata.ar@hitachi.com> <20051010174931.223310de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010174931.223310de.akpm@osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05 17:49, Andrew Morton wrote:
> 
> But it seems that this is not the case and that work continues on other
> strategies.  Is that a correct impression?  If so, what shortcoming(s) in
> kdump are causing people to be reluctant to use it?

True. There are many of us who continue to work on LKCD. Kdump is extremely
promising, but it's simply not ready for commercial use. Last I checked it
was i386 only and there are several conditions that can result in not being
able to generate a crash dump. LKCD using a non-interrupt driven based
polling mode (a la diskdump) has become quite capable of generating crash
dumps from very nasty situations. 

When kdump gets to the point where it works as well as LKCD on IA-64, i386,
and x86_64 I'll be happy to switch over. 

Troy
