Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVADV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVADV3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVADV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:29:19 -0500
Received: from hera.kernel.org ([209.128.68.125]:53470 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262102AbVADV1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:27:36 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
Date: Tue, 4 Jan 2005 21:26:54 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <crf1mu$elj$1@terminus.zytor.com>
References: <fa.ea9o20r.kje5qn@ifi.uio.no> <fa.lub44op.a2ec2d@ifi.uio.no> <E1ClnK3-0000TB-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104874014 15028 127.0.0.1 (4 Jan 2005 21:26:54 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 4 Jan 2005 21:26:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E1ClnK3-0000TB-00@be1.7eggert.dyndns.org>
By author:    Bodo Eggert <7eggert@gmx.de>
In newsgroup: linux.dev.kernel
> 
> > a = archive
> 
> Should be the "dump" attribute
> 

What dump attribute?

> > h = hidden
> > r = read only
> 
> Should be reflected by the write bits. (Maybe there should be an option to
> set the file mode for "read only" files to something different than
> $rw_mode and not 0222.)

It is.

> > s = system
> 
> Should be made "immutable", IMO

This is a filesystem mount option, but it's really unpleasant to set
it.  It's one of those things that seems to make sense, but really
doesn't.

	-hpa
