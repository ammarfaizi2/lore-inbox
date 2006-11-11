Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754860AbWKKSVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbWKKSVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbWKKSVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:21:21 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:32941 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754860AbWKKSVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:21:20 -0500
Date: Sat, 11 Nov 2006 19:20:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Burman Yan <yan_952@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Proper patch posting question
In-Reply-To: <BAY20-F93BA813AFE56E3A6BFE4DD8F60@phx.gbl>
Message-ID: <Pine.LNX.4.61.0611111919140.22893@yvahk01.tjqt.qr>
References: <BAY20-F93BA813AFE56E3A6BFE4DD8F60@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I made a patch that replaces kmalloc+memset with kzalloc. The changes are in
> many
> different places in the kernel, but most of them are trivial. The whole patch
> is about
> 360Kb. The less trivial parts that make more changes than just replacing
> kmalloc with
> kzalloc and removing the memset are in different patches that I will send to
> the proper
> maintainers.
> My question is what would be the right way to post the trivial changes?
> The way I see, I have a few options:
> 1) Post the entire patch on lkml

Split by complexity, then by size (IIRC LKML allows up to 100 KB mails, 
but keep it smaller preferably because when it gets tedious to look at a 
mail, continue 'somewhere in the middle' is hard - find the spot first)

> 2) Split the patch into subsystems and post the smaller parts on lkml

Subsystems is also a good idea.

> 3) Send the patch to trivial@kernel.org

I'd go for lkml + trivial.


	-`J'
-- 
