Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266062AbUFDXMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266062AbUFDXMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUFDXMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:12:12 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:22913 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266062AbUFDXIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:08:22 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040604132355.GA31710@tsunami.ccur.com>
References: <1086297112.3659.3.camel@lade.trondhjem.org>
	 <20040604132355.GA31710@tsunami.ccur.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086390495.4161.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 19:08:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 04/06/2004 klokka 09:23, skreiv Joe Korty:

> Hi Trond,
>  Thanks for the explanation.  What did 2.6.5 do differently that made it
> appear to work?

Nothing in the NFS client...

The only difference might be if the VM decided to flush writes out
earlier in order to reclaim memory.

Cheers,
  Trond
