Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVLGNwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVLGNwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVLGNwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:52:33 -0500
Received: from pat.uio.no ([129.240.130.16]:46826 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751025AbVLGNwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:52:32 -0500
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: "'Andreas Dilger'" <adilger@clusterfs.com>,
       "'Dave Kleikamp'" <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 08:52:08 -0500
Message-Id: <1133963528.27373.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.744, required 12,
	autolearn=disabled, AWL 1.07, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 19:57 +0900, Takashi Sato wrote:

> On my previous mail, I said that CONFIG_LBD should not determine
> whether large single files is enabled.  But after further
> consideration, on such a small system that CONFIG_LBD is disabled,
> using large filesystem over network seems to be very rare.
> So I think that the type of i_blocks should be sector_t.

???? Where do you get this misinformation from?

Cheers,
  Trond

