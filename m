Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130586AbRCITZu>; Fri, 9 Mar 2001 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130623AbRCITZk>; Fri, 9 Mar 2001 14:25:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:36533 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130586AbRCITZd>;
	Fri, 9 Mar 2001 14:25:33 -0500
Date: Fri, 9 Mar 2001 20:23:43 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103091923.UAA144612.aeb@vlet.cwi.nl>
To: mikeg@wen-online.de, viro@math.psu.edu
Subject: Re: Ramdisk (and other) problems with 2.4.2
Cc: aeb@veritas.com, linux-kernel@vger.kernel.org, root@chaos.analogic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andries, comments?

> remount
>    Attempt  to  change the mount flags of
>    already-mounted file system.  This is commonly
>    used to make a readonly file system writeable.

Yes. But maybe "mount flags" is too narrow?
It is up to the filesystem what precisely it does.
What about

remount
        Attempt to remount an  already-mounted  file
        system.  This is commonly used to change the
        mount flags for a file system, especially to
        make  a  readonly  file system writeable. It
        does not change device or mount point.
?

Andries
