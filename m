Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUCJWpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCJWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:45:51 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:44954 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262860AbUCJWpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:45:50 -0500
Subject: Re: UID/GID mapping system
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <04031015412900.03270@tabby>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby>
	 <1078941525.1343.19.camel@homer>  <04031015412900.03270@tabby>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1078958747.1940.80.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 17:45:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NFSv4 client and server already do uid/gid mapping. That is
*mandatory* in the NFSv4 protocol, which dictates that you are only
allowed to send strings of the form user@domain on the wire.

If you really need uid/gid mapping for NFSv2/v3 too, why not just build
on the existing v4 upcall/downcall mechanisms?

Cheers,
  Trond
