Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUIMTjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUIMTjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUIMTjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:39:12 -0400
Received: from hera.kernel.org ([63.209.29.2]:57261 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268883AbUIMTjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:39:11 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
Date: Mon, 13 Sep 2004 19:39:04 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ci4t0o$244$1@terminus.zytor.com>
References: <4145A8E1.8010409@qlusters.com> <200409131644.54441.arnd@arndb.de> <4145BA28.5020702@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1095104344 2181 127.0.0.1 (13 Sep 2004 19:39:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 13 Sep 2004 19:39:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4145BA28.5020702@qlusters.com>
By author:    Constantine Gavrilov <constg@qlusters.com>
In newsgroup: linux.dev.kernel
> 
> I can implement differently what I want, though it will be somewhat 
> kludgy and kernel depenedent (depends on a version and distribution). I 
> wanted to avoid that. Since what I write is really an application and 
> not interface, it was very "native" to use application syscall approach.
> 
> My real problem is not how to implement it. I want to understand this 
> specific x86_64 problem.
> 

Put it in userspace.  Really.

	-hpa
