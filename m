Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUBRLY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUBRLY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:24:59 -0500
Received: from mail.shareable.org ([81.29.64.88]:33669 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264893AbUBRLY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:24:58 -0500
Date: Wed, 18 Feb 2004 11:24:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218112447.GG28599@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <4032DA76.8070505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4032DA76.8070505@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Well, the reason you'd want an out-of-band mechanism is to be able to
> display it as some kind of escapes.

As soon as you go to "display", you need a mechanism to escape lots of
characters, not just malformed UTF-8.  Consider: \u0000, \u001B,
\u0007 and such need to be escaped too.

-- Jamie
