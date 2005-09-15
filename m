Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbVIOSj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbVIOSj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVIOSj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:39:28 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:62926 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030569AbVIOSj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:39:27 -0400
Message-ID: <4329BFDC.70600@v.loewis.de>
Date: Thu, 15 Sep 2005 20:39:24 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4B2ZV-2dl-7@gated-at.bofh.it> <4HKbZ-Cx-37@gated-at.bofh.it> <4329BC43.7030406@v.loewis.de> <4329BCAB.1090106@zytor.com>
In-Reply-To: <4329BCAB.1090106@zytor.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> In Unix, it's a hideously bad idea.  The reason is that Unix inherently
> assumes that text streams can be merged, split, and modified.  In other
> words, unless you can guarantee that EVERY program can handle BOM
> EVERYWHERE, it's broken.

This argument is bogus. We are talking about scripts here, which cannot
be merged, split, and modified. You don't cat(1) or sort(1) them - it's
just pointless to do that. You create them with text editors, and those
*can* handle the UTF-8 signature.

> In other words, it's broken.

We can do that now, or in five or ten years. I'm willing to wait that
long, but I'm certain that more people will find the UTF-8 signature
useful over time. It's the only sane way to get non-ASCII into script
source in a consistent way.

Regards,
Martin
