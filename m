Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273265AbRIWElO>; Sun, 23 Sep 2001 00:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273268AbRIWElF>; Sun, 23 Sep 2001 00:41:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18085 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273265AbRIWEkt>;
	Sun, 23 Sep 2001 00:40:49 -0400
Date: Sun, 23 Sep 2001 00:41:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Cinege <dcinege@psychosis.com>
cc: linux-kernel@vger.kernel.org, LRP <linux-router@linuxrouter.org>,
        LRPD <linux-router-devel@linuxrouter.org>
Subject: Re: [PATCH] Initrd Dynamic v4.2 - New Feature: Tmpfs root support
In-Reply-To: <E15l0m0-0004cH-00@schizo.psychosis.com>
Message-ID: <Pine.GSO.4.21.0109230036450.13262-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Sep 2001, David Cinege wrote:

> Linus and Alan, 
> 
> Initrd Dynamic is mature, stable, well mantained code. It makes very minimal 
> impact to the current source tree, segrigating itself to it's own source 
> files. It is fully backwards compatible with current initrd operations.
> 
> Please consider it for inclusion in the next 2.4 kernel release.

Sigh...  With initramfs it can be done in userland.  _Please_, let's stop
adding complexity to already ridiculously bloated late boot stages.
David, no offence, but let's do it the right way.

