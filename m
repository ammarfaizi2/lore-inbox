Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130083AbRB1HO3>; Wed, 28 Feb 2001 02:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130081AbRB1HOK>; Wed, 28 Feb 2001 02:14:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40414 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129257AbRB1HOF>;
	Wed, 28 Feb 2001 02:14:05 -0500
Date: Wed, 28 Feb 2001 02:14:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <200102280703.f1S73ft487578@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0102280213000.4827-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Albert D. Cahalan wrote:

> Alexander Viro writes:
> 
> > 	* CLONE_NEWNS is made root-only (CAP_SYS_ADMIN, actually)
> 
> Would an unprivileged version that killed setuid be OK to have?

Not until we get decent resource accounting here.

> Evil idea of the day: non-directory (even non-existant) mount points and
> non-directory mounts. So then "mount --bind /etc/foo /dev/bar" works.

Try it. It _does_ work.

