Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUFQSRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUFQSRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUFQSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:17:43 -0400
Received: from ceiriog1.demon.co.uk ([194.222.75.230]:44161 "EHLO
	ceiriog1.demon.co.uk") by vger.kernel.org with ESMTP
	id S261378AbUFQSRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:17:42 -0400
Subject: Re: Irix NFS servers, again :-)
From: Peter Wainwright <prw@ceiriog1.demon.co.uk>
To: Steve Lord <lord@xfs.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40D1DAEA.8030103@xfs.org>
References: <1087411925.30092.35.camel@ceiriog1.demon.co.uk>
	 <20040617134424.GA32272@infradead.org>
	 <1087491319.3677.5.camel@ceiriog1.demon.co.uk>  <40D1DAEA.8030103@xfs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087495972.15215.2.camel@ceiriog1.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Jun 2004 19:12:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 18:54, Steve Lord wrote:

> 
> Part of the fix for these issues with Irix NFS was version 2
> directories in XFS, this made directory offsets in XFS into
> real offsets rather than 64 bit hash values.
> 
> If your filesystem is old enough, it will have version 1
> directories - and the only conversion process is to do
> a dump/mkfs/restore.
> 
> xfs_growfs -n /mntpnt will report the directory version
> as naming=1 or naming=2 if I recall correctly.
> 
> Steve

Thanks, that explains it. The filesystem in question
indeed has naming=1. Now I just have to work out whether it is
worth the effort of conversion or whether I can live with a
kludged linux client (glibc or kernel).
Thanks to all who replied...


Peter

