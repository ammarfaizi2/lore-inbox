Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSLVTNU>; Sun, 22 Dec 2002 14:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLVTNU>; Sun, 22 Dec 2002 14:13:20 -0500
Received: from [195.208.223.238] ([195.208.223.238]:38784 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265168AbSLVTNT>; Sun, 22 Dec 2002 14:13:19 -0500
Date: Sun, 22 Dec 2002 22:21:06 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021222222106.B30070@localhost.park.msu.ru>
References: <m17ke3m3gl.fsf@frodo.biederman.org> <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> <15877.26255.524564.576439@argo.ozlabs.ibm.com> <1040569382.1966.11.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1040569382.1966.11.camel@zion>; from benh@kernel.crashing.org on Sun, Dec 22, 2002 at 04:03:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 04:03:01PM +0100, Benjamin Herrenschmidt wrote:
> The code has a comment that clearly says that we don't know why address
> decoding is turned off and that should be fixed, so I suggest we either
> fix it now or replace the comment with an explanation of why we need to
> turn it off ;)

It certainly wants to be fixed, thanks. Looks like a thinko.

Just out of curiosity, formerly you mentioned that said ASIC cannot
be relocated in the PCI address space, why? Firmware issues or anything
else?

Ivan.
