Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUFGQxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUFGQxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUFGQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:53:30 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:15232 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264924AbUFGQx3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:53:29 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
In-Reply-To: <20040607163920.GB22505@tsunami.ccur.com>
References: <1086625209.4597.0.camel@lade.trondhjem.org>
	 <20040607163920.GB22505@tsunami.ccur.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086627207.4597.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 12:53:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 07/06/2004 klokka 12:39, skreiv Joe Korty:
> > 
> > With what? There has never been a standard other than the close-to-open.
> 
> Compatibility with existing behavior.  It's called a de-facto standard.

The "de-facto standard" you describe has never existed other than for
large files. It was never true of small files that did not trigger
immediate writeout.

