Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbULPTwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbULPTwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULPTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:52:18 -0500
Received: from brown.brainfood.com ([146.82.138.61]:40885 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262021AbULPTul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:50:41 -0500
Date: Thu, 16 Dec 2004 13:50:40 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-pre2
In-Reply-To: <20041216113559.GF8246@logos.cnet>
Message-ID: <Pine.LNX.4.58.0412161349260.2173@gradall.private.brainfood.com>
References: <20041216113559.GF8246@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Marcelo Tosatti wrote:

> Hi,
>
> Here goes the second -pre of Linux v2.4.29.

I don't know if you've been following, but it was recently discoverd that on
smp, if multiple processes read from /dev/urandom at the same time, they can
get the same data.  Theodore Tytso posted a patch to fix this for 2.6, and
someone else told me this problem has existed all the way back to 1.3.

This is a security issue, and should be included in the 2.4 tree.
