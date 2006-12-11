Return-Path: <linux-kernel-owner+w=401wt.eu-S937386AbWLKR6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937386AbWLKR6i (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937391AbWLKR6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:58:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40137 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937386AbWLKR6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:58:37 -0500
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
From: Arjan van de Ven <arjan@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061211175026.GA18628@aepfle.de>
References: <457D750C.9060807@shadowen.org>
	 <20061211163333.GA17947@aepfle.de>
	 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	 <20061211175026.GA18628@aepfle.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 11 Dec 2006 18:57:53 +0100
Message-Id: <1165859874.27217.382.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 18:50 +0100, Olaf Hering wrote:
> On Mon, Dec 11, Linus Torvalds wrote: 
> > What crud. I'm even slightly inclined to just let SLES9 be broken, just to 
> > let people know how unacceptable it is to look for strings in kernel 
> > binaries. But sadly, I don't think the poor users should be penalized for 
> > some idiotic SLES developers bad taste.
> 
> SLES7 or SLES11 is not any different than SLES9 in that respect.
> Suppose I send you some random vmlinux binary. How do you (you as in linus.sh)
> know what 'uname -r' is inside this binary?
> There are surely many many ways to pass that info. Having a string like
> 'Linux version 2.6.19-g9202f325-dirty' somewhere in the binary is the
> most reliable one. Dont you agree?

it's for sure the most ugly one. I could see the use of having modinfo
work on the vmlinux, and have the vmlinux have a VERMAGIC as well. It's
only a simple elf section after all, and a heck of a lot more defined
and standard...



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

