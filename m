Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264458AbTDPQtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDPQs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:48:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37060
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264458AbTDPQrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:47:42 -0400
Subject: RE: How to identify contents of /lib/modules/*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45B36A38D959B44CB032DA427A6E1064045133AB@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E1064045133AB@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050508885.28727.137.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 17:01:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 16:58, Cameron, Steve wrote:
> I think it's the use of "--force" option to RPM that causes this,
> or else, faulty RPMs.  It's not so easy to make a well-behaved
> RPM.  Having tried myself, sometimes I think maybe RPM 
> really stands for "Revolting Pile of Manure". (no offense ;-) Of 
> course I'm probably trying to bend it do a job for which perhaps 
> it is not so well suited.

Only --force allows the same file to be owned by two packages. Otherwise
RPM throws a fit about it. People who use --force I file in the same
category as overclockers, CB amp hackers and the like 8)

At that point the answer basically is what is being run depends on 
precisely what order it was forced and how. Its probably not sanely
computable.


