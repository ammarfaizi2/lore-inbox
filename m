Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWARPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWARPsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWARPsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:48:10 -0500
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:14558 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1030352AbWARPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:48:09 -0500
X-IronPort-AV: i="3.99,381,1131339600"; 
   d="scan'208"; a="1722952998:sNHT27666650"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.25398.943860.755559@smtp.charter.net>
Date: Wed, 18 Jan 2006 10:48:06 -0500
From: "John Stoffel" <john@stoffel.org>
To: "Takashi Sato" <sho@tnes.nec.co.jp>
Cc: <ext2-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: Extends blocksize up to pagesize
In-Reply-To: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Takashi> As a disk tends to get large, a disk storage has had a
Takashi> capacity to supply multi-TB.  But now, ext3 can't support
Takashi> more than 8TB filesystem when blocksize is 4KB.  That's why I
Takashi> think ext3 needs to be more than 8TB.

Man, I don't want to even think about doing an FSCK on an 8TB
filesystem running ext[23] at all.  

In that size range, you really need a filesystem which doesn't need an
FSCK at all.  Not sure what the real answer is though...

John
