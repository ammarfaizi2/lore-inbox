Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUH2PeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUH2PeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUH2PeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:34:06 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8577 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268033AbUH2PeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:34:03 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Rik van Riel <riel@redhat.com>, Christer Weinigel <christer@weinigel.se>,
       Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>,
       wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
	 <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093789802.27932.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 15:30:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-26 at 16:19, Denis Vlasenko wrote:
> > Office suites can store a document with embedded images
> > and spread sheets "easily" by putting the text, the
> > images and spread sheets all in different file streams.
> 
> Kinda far reaching. It's hard to assess whether that is good or bad idea.
> Can we start small, like putting metadata (e.g. ACLs) into these streams?

Openoffice does this in user space and the user space vfs code desktops
use can handle zips so this "just works" already including over NFS,
unlike a kernel proposed method.

