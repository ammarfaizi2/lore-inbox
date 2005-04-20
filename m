Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVDTU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVDTU3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVDTU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 16:29:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14746 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261802AbVDTU32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 16:29:28 -0400
Date: Wed, 20 Apr 2005 22:29:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Colin Leroy <colin@colino.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: add an option to force r/w mount
In-Reply-To: <20050420220242.48cb1427@jack.colino.net>
Message-ID: <Pine.LNX.4.61.0504202227370.857@scrub.home>
References: <20050420220242.48cb1427@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 20 Apr 2005, Colin Leroy wrote:

> for some reason yet unknown, fsck.hfsplus doesn't correctly set the
> HFSPLUS_VOL_UNMNT flag here.

If fsck doesn't mark it clean, there must be a reason and that also means 
you shouldn't mount it writable.

bye, Roman

