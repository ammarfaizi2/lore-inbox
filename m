Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVCGSCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVCGSCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCGSCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:02:38 -0500
Received: from pat.uio.no ([129.240.130.16]:30082 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261200AbVCGSCf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:02:35 -0500
Subject: Re: NFS problem in 2.4.21 (RHEL ES 3 upd 2)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: campbell@accelinc.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050307163711.GB11949@helium.inexs.com>
References: <20050307163711.GB11949@helium.inexs.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Mar 2005 13:02:27 -0500
Message-Id: <1110218547.11489.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.458, required 12,
	autolearn=disabled, AWL 1.54, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 07.03.2005 Klokka 10:37 (-0600) skreiv Chuck Campbell:
> I've just built a cluster of dual Opteron boxes, running RHEL 3 update 2
> x86_64 OS.
> 
> I have problems creating files larger than 2GB on an NFS mounted filesystem.
> 

Are you perhaps using NFSv2? If so, I suggest you try NFSv3, as the
NFSv2 protocol does not support 64-bit file sizes.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

