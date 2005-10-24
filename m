Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVJXSCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJXSCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVJXSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:44 -0400
Received: from pat.uio.no ([129.240.130.16]:58790 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751211AbVJXSCR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:17 -0400
Subject: Re: [PATCH 1/8] VFS: pass file pointer to filesystem from
	ftruncate()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EU5XO-0005rf-00@dorka.pomaz.szeredi.hu>
References: <E1EU5XO-0005rf-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=utf-8
Date: Mon, 24 Oct 2005 14:01:56 -0400
Message-Id: <1130176917.9102.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.262, required 12,
	autolearn=disabled, AWL 0.23, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 24.10.2005 klokka 18:51 (+0200) skreiv Miklos Szeredi:
> This patch extends the iattr structure with a file pointer memeber,
> and adds an ATTR_FILE validity flag for this member.
> 
> This is set if do_truncate() is invoked from ftruncate() or from
> do_coredump().

This would be very useful for the NFSv4 client too.

Cheers,
  Trond

