Return-Path: <linux-kernel-owner+w=401wt.eu-S937387AbWLKSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937387AbWLKSAk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937389AbWLKSAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:00:40 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59554 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937387AbWLKSAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:00:39 -0500
Date: Mon, 11 Dec 2006 19:00:49 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211180049.GA18821@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de> <1165859874.27217.382.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1165859874.27217.382.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Arjan van de Ven wrote:

> it's for sure the most ugly one. I could see the use of having modinfo
> work on the vmlinux, and have the vmlinux have a VERMAGIC as well. It's
> only a simple elf section after all, and a heck of a lot more defined
> and standard...

Just go for it. Remember there is also that bzImage thingy, no idea how
its layed out, it has to work there too.
