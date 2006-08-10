Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWHJUQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWHJUQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWHJUQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:16:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:19588 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932627AbWHJUOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:14:10 -0400
Message-ID: <44DB945F.5080102@suse.com>
Date: Thu, 10 Aug 2006 16:17:35 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <20060810191747.GL20581@ca-server1.us.oracle.com> <20060810194440.GA6845@martell.zuzino.mipt.ru>
In-Reply-To: <20060810194440.GA6845@martell.zuzino.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexey Dobriyan wrote:
> On Thu, Aug 10, 2006 at 12:17:47PM -0700, Joel Becker wrote:
>> On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
>>> On Wed, 09 Aug 2006 18:20:43 -0700
>>> Mingming Cao <cmm@us.ibm.com> wrote:
>>>
>>>> Define SECTOR_FMT to print sector_t in proper format
>>> We've thus-far avoided doing this.  In fact a similar construct in
>>> device-mapper was recently removed.
>> 	Yeah, OCFS2 had similar formats, and we were asked to change
>> them to naked casts before inclusion.  Seems quite consistent with the
>> rest of the kernel.
> 
> Will
> 
> 	printk("%S", sector_t);
> 
> kill at least one kitten?

I like the general idea. I think that having to cast every time you want
to print a sector number is pretty gross. I had something more like %Su
in mind, though.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE25RfLPWxlyuTD7IRAshdAJ0dboV4trG1Pgy6P+sqPiV0bWabYQCgiZng
FuaanX+K+jSTwlrapumR1XY=
=jLoe
-----END PGP SIGNATURE-----
