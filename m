Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUCKOKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUCKOKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:10:50 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:51697 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261358AbUCKOKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:10:48 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: UID/GID mapping system
Date: Thu, 11 Mar 2004 08:10:21 -0600
X-Mailer: KMail [version 1.2]
Cc: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <1078958747.1940.80.camel@nidelv.trondhjem.org>
In-Reply-To: <1078958747.1940.80.camel@nidelv.trondhjem.org>
MIME-Version: 1.0
Message-Id: <04031108102101.05054@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 16:45, Trond Myklebust wrote:
> The NFSv4 client and server already do uid/gid mapping. That is
> *mandatory* in the NFSv4 protocol, which dictates that you are only
> allowed to send strings of the form user@domain on the wire.
>
> If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> on the existing v4 upcall/downcall mechanisms?

Drat... I completely forgot about that. It's been a year since I used NFS
at all.

That would be the best way.
