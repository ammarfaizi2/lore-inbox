Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUFFTR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUFFTR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUFFTR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:17:29 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:28547 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264058AbUFFTR1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:17:27 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, joe.korty@ccur.com
In-Reply-To: <200406040525.40972.ioe-lkml@rameria.de>
References: <20040603202846.GA28479@tsunami.ccur.com>
	 <1086297112.3659.3.camel@lade.trondhjem.org>
	 <200406040525.40972.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086549445.5472.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 15:17:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 03/06/2004 klokka 23:25, skreiv Ingo Oeser:
> On Thursday 03 June 2004 23:11, Trond Myklebust wrote:
> > ...and no - we do not update timestamps on the client side when we cache
> > the write, 'cos NFS does not provide any device for ensuring that clocks
> > on client and server are synchronized.
> 
> Could you make this an option? The device ensuring this is the an admin
> with a clue, who configures NTP or similiar in his network.
> 
> If unsure you could at least disable it by default.

Why? It still won't be set to the same value as on the server.

Cheers,
  Trond
