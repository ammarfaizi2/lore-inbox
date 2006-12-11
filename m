Return-Path: <linux-kernel-owner+w=401wt.eu-S937438AbWLKSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937438AbWLKSW2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763001AbWLKSW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:22:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51302 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763006AbWLKSW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:22:27 -0500
Date: Mon, 11 Dec 2006 10:19:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211175026.GA18628@aepfle.de>
Message-ID: <Pine.LNX.4.64.0612111019020.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Olaf Hering wrote:
> 
> SLES7 or SLES11 is not any different than SLES9 in that respect.
> Suppose I send you some random vmlinux binary. How do you (you as in linus.sh)
> know what 'uname -r' is inside this binary?
> There are surely many many ways to pass that info. Having a string like
> 'Linux version 2.6.19-g9202f325-dirty' somewhere in the binary is the
> most reliable one. Dont you agree?
> Just think about it for a minute.

YOU just think about it for a minute.

Your basic problem was much earlier:

	"Suppose I send you some random vmlinux binary."

THAT is the problem.

		Linus
