Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270140AbUJTIbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270140AbUJTIbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbUJTI0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:26:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269536AbUJTIXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:23:02 -0400
Message-ID: <41762058.3000304@pobox.com>
Date: Wed, 20 Oct 2004 04:22:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
References: <1098254970.3223.6.camel@gaston>
In-Reply-To: <1098254970.3223.6.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Hi Linus !
> 
> After you tag a "release" tree in bk, could you bump the version number
> right away, with eventually some junk in EXTRAVERSION like "-devel" ?
> 
> It's quite painful to have a module dir name clash between the "clean"
> final tree and whatever dev stuff we are testing out of bk ... it's fine
> once you go to -rc1, but in the meantime, it's really annoying.

echo "-bk" > localversion
make

You can do it just as easily as anyone else :)

	Jeff



