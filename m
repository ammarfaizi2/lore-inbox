Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUBGCyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUBGCyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:54:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:28112 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266502AbUBGCyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:54:12 -0500
Date: Sat, 7 Feb 2004 02:54:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: linux-kernel@vger.kernel.org, infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the Linux kernel
Message-ID: <20040207025404.GJ12503@mail.shareable.org>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96A4@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96A4@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tillier, Fabian wrote:
> Further, comments in the x86 code base indicated that only 24-bits
> are actually valid (probably from some i386 limitation that is no
> longer relevant).

It is because of the Sparc architecture.  I think Sparc doesn't (or
perhaps didn't) have atomic operations, so a cunning hack is used to
simulate them.

-- Jamie
