Return-Path: <linux-kernel-owner+willy=40w.ods.org-S378960AbUKAWvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S378960AbUKAWvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378952AbUKAWvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:51:02 -0500
Received: from pat.uio.no ([129.240.130.16]:27861 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S310469AbUKAU6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:58:08 -0500
Subject: Re: [PATCH] reduce stack usage of NFS (was Re: How to safely
	reduce...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099040501.2641.9.camel@laptop.fenrus.org>
	 <1099059626.11099.10.camel@dh138.citi.umich.edu>
	 <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 12:57:37 -0800
Message-Id: <1099342657.7240.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 30.10.2004 Klokka 00:59 (+0300) skreiv Denis Vlasenko:

> This patch reduces stack usage to below 100 bytes for
> the following functions:
...
> Please review, especially for leaks on error paths.

Looks alright, apart from the ENOMEM return for nfs_lookup_revalidate()
that I already pointed out to you.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

