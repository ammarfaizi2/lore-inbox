Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbULMLUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbULMLUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbULMLUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:20:12 -0500
Received: from linux2.isphuset.no ([213.236.237.186]:37092 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S262216AbULMLUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:20:05 -0500
Subject: Re: dynamic-hz
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, andrea@suse.de, pavel@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213030237.5b6f6178.akpm@osdl.org>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <20041213030237.5b6f6178.akpm@osdl.org>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1102936790.17227.24.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Dec 2004 12:19:50 +0100
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 12:02, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > The performance benefit, if any, is often lost in noise during 
> >  benchmarks and when there, is less than 1%. So I was wondering if you 
> >  had some specific advantage in mind for this patch? Is there some 
> >  arch-specific advantage? I can certainly envision disadvantages to lower Hz.
> 
> There are apparently some laptops which exhibit appreciable latency between
> the start of ACPI sleep and actually consuming less power.  The 1ms wakeup
> frequency will shorten battery life on these machines significantly.  (I
> forget the exact numbers - Len will know).

Is there any recommended lower bound setting?
Would there be a point in recommending lower settings for desktops
running only text consoles opposed to X desktops?

-HK

