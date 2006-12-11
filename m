Return-Path: <linux-kernel-owner+w=401wt.eu-S1763012AbWLKSkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763012AbWLKSkh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937469AbWLKSkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:40:37 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:36349 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763013AbWLKSkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:40:36 -0500
Date: Mon, 11 Dec 2006 19:40:44 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211184044.GA19244@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de> <Pine.LNX.4.64.0612111019020.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111019020.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Linus Torvalds wrote:

> 	"Suppose I send you some random vmlinux binary."
> 
> THAT is the problem.

Erm no, thats reality and happens every day. git-bisect a modular kernel
on one box and test it on another. The mkinitrd (and depmod) wants to know
where to look for modules.
Of course I could tell it every time what the kernelrelease is, but why
do I have to?
