Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVGHQ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVGHQ6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVGHQ6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:58:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6836 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262719AbVGHQ5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:57:51 -0400
Date: Fri, 8 Jul 2005 18:57:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Bryan Henderson <hbryan@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
In-Reply-To: <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507081845170.3743@scrub.home>
References: <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Bryan Henderson wrote:

> I wasn't aware anyone preferred defines to enums for declaring enumerated 
> data types.

If it's really enumerated data types, that's fine, but this example was 
about bitfield masks.

> Isn't the only argument for defines, "that's what I'm used to."?

defines are not just used for constants and there is _nothing_ wrong with 
using defines for constants.

> The macro language is one the most hated parts of the C language; it makes 
> sense to try to avoid it as a general rule.

Nevertheless it's part of the language, it's used all over the kernel and 
suddenly starting to mix different types of definitions, makes things 
only worse. I prefer consistency here over any minor advantages enums 
might have.

bye, Roman
