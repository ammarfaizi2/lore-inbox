Return-Path: <linux-kernel-owner+w=401wt.eu-S1762999AbWLKRuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762999AbWLKRuU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762988AbWLKRuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:50:19 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58381 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762972AbWLKRuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:50:18 -0500
Date: Mon, 11 Dec 2006 18:50:26 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211175026.GA18628@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Linus Torvalds wrote: 
> What crud. I'm even slightly inclined to just let SLES9 be broken, just to 
> let people know how unacceptable it is to look for strings in kernel 
> binaries. But sadly, I don't think the poor users should be penalized for 
> some idiotic SLES developers bad taste.

SLES7 or SLES11 is not any different than SLES9 in that respect.
Suppose I send you some random vmlinux binary. How do you (you as in linus.sh)
know what 'uname -r' is inside this binary?
There are surely many many ways to pass that info. Having a string like
'Linux version 2.6.19-g9202f325-dirty' somewhere in the binary is the
most reliable one. Dont you agree?
Just think about it for a minute.
