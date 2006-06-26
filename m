Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933114AbWFZWco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbWFZWco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933120AbWFZWcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:32:35 -0400
Received: from pat.uio.no ([129.240.10.4]:13195 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S933110AbWFZWcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:32:18 -0400
Subject: Re: NFS and partitioned md
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Martin Filip <bugtraq@smoula.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151360087.8325.2.camel@archon.smoula-in.net>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <1151355509.9797.7.camel@lade.trondhjem.org>
	 <1151356840.4460.18.camel@archon.smoula-in.net>
	 <1151358717.9797.13.camel@lade.trondhjem.org>
	 <1151360087.8325.2.camel@archon.smoula-in.net>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 18:32:00 -0400
Message-Id: <1151361121.9797.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.803, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 00:14 +0200, Martin Filip wrote:

> Yes, of course... that dir and everything in that is world readable
> (+executable when it is directory)
> Everything worked with same settings, versions and everything between
> switching my multiple md devices into md_d. And even now it works on
> other devices than md_d.

So would you then please help us determine what the difference between
the two setups actually is?

knfsd knows bugger all about what device you are running your filesystem
on. All it cares about is that the type of filesystem is supported.

Cheers,
  Trond

