Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUHYVej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUHYVej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHYVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:33:26 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:43732 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S268420AbUHYVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:23:42 -0400
Date: Wed, 25 Aug 2004 17:23:05 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
In-reply-to: <20040825205618.GA7992@hockin.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Rik van Riel <riel@redhat.com>, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Message-id: <412D0339.3080601@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <410D96DC.1060405@namesys.com>
 <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
 <20040825205618.GA7992@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Hockin wrote:
> On Wed, Aug 25, 2004 at 04:25:24PM -0400, Rik van Riel wrote:
>
>>>You can think of this as chroot on steroids.
>>
>>Sounds like what you want is pretty much the namespace stuff
>>that has been in the kernel since the early 2.4 days.
>>
>>No need to replicate VFS functionality inside the filesystem.
>
>
> When I was at Sun, we talked a lot about this.  Mike, does Sun have any
> iterest in this?

Not that I know of.  I believe the functionality Hans is looking for has
already been handled by SELinux.  What is needed (if it doesn't already
exist) is a tool to gather these 'viewprints' automagically.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLQM4dQs4kOxk3/MRArXMAJ0WTzw8L/vLNO3lYwkCdGJGrzRBKgCcD7l7
w6eSrLFYVHoQ9CiAruQCV9E=
=PVV9
-----END PGP SIGNATURE-----
