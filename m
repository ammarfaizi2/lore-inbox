Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWIYAeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWIYAeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWIYAeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:34:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751530AbWIYAeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:34:19 -0400
Date: Sun, 24 Sep 2006 17:34:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] add and use include/linux/magic.h
In-Reply-To: <45172297.6070108@garzik.org>
Message-ID: <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
 <45172297.6070108@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Sep 2006, Jeff Garzik wrote:
> 
> Right now I just pipe 'git diff master..branch' to diffstat.

Ok. That just means that you can change it do say

	git diff -M --stat --summary master..branch

and you get exactly what you need. No need for a separate diffstat at all, 
and you get all the renaming and summary printout.

		Linus
