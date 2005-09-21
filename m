Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVIUPF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVIUPF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVIUPF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:05:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751055AbVIUPF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:05:57 -0400
Date: Wed, 21 Sep 2005 08:05:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys
In-Reply-To: <12434.1127314090@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0509210803310.2553@g5.osdl.org>
References: <5378.1127211442@warthog.cambridge.redhat.com> 
 <12434.1127314090@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Sep 2005, David Howells wrote:
> 
> The attached patch adds extra permission grants to keys for the possessor of a
> key in addition to the owner, group and other permissions bits. This makes
> SUID binaries easier to support without going as far as labelling keys and key
> targets using the LSM facilities.

Ok, maybe I'm just strange, but when I see code like

	if (is_key_possessed(keyref)) {

I'm inevitably mentally going "Linda Blair! It is spewing pea-soup and
rotating its head!"

Maybe not the best of naming practices..

		Linus
