Return-Path: <linux-kernel-owner+w=401wt.eu-S936965AbWLKSOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936965AbWLKSOV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937052AbWLKSOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:14:21 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33043 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936965AbWLKSOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:14:20 -0500
Date: Mon, 11 Dec 2006 19:14:30 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211181430.GA18963@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <20061211175026.GA18628@aepfle.de> <1165859874.27217.382.camel@laptopd505.fenrus.org> <20061211180049.GA18821@aepfle.de> <1165860500.27217.388.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1165860500.27217.388.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Arjan van de Ven wrote:

> strings doesn't work there, it's a compressed image!
Thats why get_kernel_version calls gzip.

> also... can't you just know which vmlinux it is in the first place?

No, you cant.

> (or in other words, why is SLES the only one with the problem?)

Everyone has this "problem". Or how do you know what kernelrelease is
inside a random ELF or bzImage binary?
