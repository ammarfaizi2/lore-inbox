Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbULKATk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbULKATk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbULKATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:19:40 -0500
Received: from brown.brainfood.com ([146.82.138.61]:28071 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261888AbULKATe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:19:34 -0500
Date: Fri, 10 Dec 2004 18:19:16 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <20041210212815.GB25409@thunk.org>
Message-ID: <Pine.LNX.4.58.0412101818310.2173@gradall.private.brainfood.com>
References: <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org>
 <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org>
 <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org>
 <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org>
 <20041210163558.GB10639@thunk.org> <20041210182804.GT8876@waste.org>
 <20041210212815.GB25409@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this problem a security issue?  On SMP, couldn't an attacker read from
/dev/urandom, then know what other programs have read, and use that to do some
kind of subversion?
