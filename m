Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVFXJFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVFXJFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVFXJEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:04:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14235 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263063AbVFXJD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:03:59 -0400
Message-ID: <42BBCC65.8060709@namesys.com>
Date: Fri, 24 Jun 2005 02:03:33 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alexander Zarochentcev <zam@namesys.com>
CC: Lincoln Dale <ltd@cisco.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <42BB7083.2070107@cisco.com> <42BBAD0F.2040802@namesys.com> <20050624071159.GQ29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050624071159.GQ29811@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>Have I missed the posting with analysis of changes in locking scheme
>and update of proof of correctness?  If so, please give the message ID.
>
>_That_ had been the major showstopper for any merges, IIRC.
>  
>
Ah, the prince of helpfulness has arrived.

Yes, as I remember, last time with V3 you announced that there were race
conditions that we needed to fix if V3 was to be merged, you would not
tell us what they were when asked, Linus merged us anyway, you never did
tell us what they were, later vs fixed some race conditions but I have
no idea if they were the same ones you found, oh well, getting rid of
bugs never was your objective was it?  Does V3 still have those race
conditions you spoke of?

Proof of correctness, is that where we check and see if the filesystems
all mount/unmount before checking in code changes to the stable release
branch?  Oh dear, that was unkind of me.

Ok, sure, define what you want in the way of a proof of correctness and
an analysis.  Is this a new VFS tradition?  Is it documented anywhere? 
Are there tools for it?  Probably I should ask Zam if we already did it
too.....  Zam?

Hans
