Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031916AbWLGJqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031916AbWLGJqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031917AbWLGJqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:46:50 -0500
Received: from verein.lst.de ([213.95.11.210]:41989 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031916AbWLGJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:46:49 -0500
Date: Thu, 7 Dec 2006 10:46:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [MIPS] Import updates from i386's i8259.c
Message-ID: <20061207094639.GA30260@lst.de>
References: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.349 () BAYES_30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 08:15:47PM +0000, linux-mips@linux-mips.org wrote:
> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Thu Dec 7 02:04:17 2006 +0900
> Comitter: Ralf Baechle <ralf@linux-mips.org> Wed Dec 6 20:10:54 2006 +0000
> Commit: bf8cfe1360932f191a3ea8d47c773c008ec32cd7
> Gitweb: http://www.linux-mips.org/g/linux/bf8cfe13
> Branch: master
> 
> Import many updates from i386's i8259.c, especially genirq transitions.

Shouldn't we try to share i8259.c over the various architectures that
use this controller?  With the generic hardirq framework that should be
possible.

