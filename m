Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSJUK04>; Mon, 21 Oct 2002 06:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSJUK04>; Mon, 21 Oct 2002 06:26:56 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29875 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261330AbSJUK0z>; Mon, 21 Oct 2002 06:26:55 -0400
Subject: Re: Add extended attributes to ext2/3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, "Theodore Ts'o" <tytso@mit.edu>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021015220144.GK15552@clusterfs.com>
References: <200210151640.15581.agruen@suse.de>
	<20021015182943.GA1335@think.thunk.org> <200210152300.32190.agruen@suse.de>
	 <20021015220144.GK15552@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 11:48:26 +0100
Message-Id: <1035197306.27318.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 23:01, Andreas Dilger wrote:
> Just as an FYI - marking ext3 inodes dirty is an expensive operation,
> and should be done only once if at all possible (not sure if the same
> code applies to ext3 as you are discussing ext2, but I thought I should
> mention it).

Yes its noticable that 2.4 makes ext3 inodes dirty unneccessarily in
some cases. Its one of the things Pete Zaitsev of mysql pointed out to
me.

