Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUEBQTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUEBQTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUEBQTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:19:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:29892 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263174AbUEBQS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:18:58 -0400
X-Authenticated: #20450766
Date: Sun, 2 May 2004 18:18:20 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: GNU/Dizzy <dizzy@roedu.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
In-Reply-To: <Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net>
Message-ID: <Pine.LNX.4.44.0405021806460.1477-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004, GNU/Dizzy wrote:

> > for filesystem metadata, journals... Making those directories soft-links
> > into one writable partition would work, but is not too nice.
>
> How about mounting the big volume somewhere and using -o bind to mount
> some paths within it in different places of your needs ? I know that -o
> bind doesnt honor -o ro yet but if you really needed maybe you can make a
> patch for that, I for one would be very interested about that.
> check "man mount" about more information about "bind"
>
> Also notice that linux (starting with some 2.3.x version if I remember
> well) already supports multiple mount points for a given "source" like
> mount /dev/hda1 /mnt1
> mount /dev/hda1 /mnt2 and so on

See "not nice" above. With the proposed option I would like to avoid
having one file appear at multiple paths. IOW each file would appear in no
more than 1 place in the tree.

Guennadi
---
Guennadi Liakhovetski


