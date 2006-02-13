Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWBMIGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWBMIGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWBMIGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:06:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8467 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751222AbWBMIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:06:50 -0500
Date: Mon, 13 Feb 2006 09:03:31 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linda Walsh <lkml@tlinx.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060213080331.GH11380@w.ods.org>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org> <20060213073746.GG11380@w.ods.org> <1139816896.2997.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139816896.2997.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Mon, Feb 13, 2006 at 08:48:15AM +0100, Arjan van de Ven wrote:
> 
> > I don't know exactly why recursion is used to follow symlinks,
> > which at first thought seems like it could be iterated, but
> > I've not checked the code, there certainly are specific reasons
> > for this.
> 
> the problem is not following symlinks. the problem is symlinks to
> symlink to symlink to ...

That's how I understood it, but I only thought about easy cases. Now,
I can imagine cross-FS links and I don't see an easy way to resolve
them :-/

Cheers,
Willy

