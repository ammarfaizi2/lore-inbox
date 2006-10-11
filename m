Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161384AbWJKVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161384AbWJKVaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161520AbWJKVag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:30:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19908 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161384AbWJKVa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:30:26 -0400
Date: Wed, 11 Oct 2006 23:30:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
In-Reply-To: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610112319320.7817@scrub.home>
References: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Oct 2006, Al Viro wrote:

> cretinous thing doesn't believe that (%a0)+ is one macro argument and
> splits it in two; worked around by quoting the argument...

NAK, this is a bug in binutils and is fixed there already (at least in 
CVS).

bye, Roman
