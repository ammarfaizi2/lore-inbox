Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVA0HnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVA0HnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVA0HnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:43:12 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:48339 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262022AbVA0HnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:43:07 -0500
Message-ID: <41F89B9F.8010605@comcast.net>
Date: Thu, 27 Jan 2005 02:43:27 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk> <41F86176.3010000@comcast.net> <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>            <41F88F59.6040904@comcast.net> <200501270710.j0R7AhIN003672@turing-police.cc.vt.edu>
In-Reply-To: <200501270710.j0R7AhIN003672@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Thu, 27 Jan 2005 01:51:05 EST, John Richard Moser said:
> 
> 
>>mmm.  I'd thought about that actually-- for modules to get a whack at
>>this they'd have to be compiled in.  Loaded as modules would break the
>>security.
> 
> 
> And that, my friends, is *exactly* why SELinux can't be built as a module ;)

:) So far my little grkernsec module hasn't hit any bumps like that;
though so far I haven't copied much of spender's code.  I'm sure the
chroot() restrictions will easily be make for a loadable module.

At this point, I should be making more important design decisions.  For
example, why am I still doing this?  Isn't there something better for me
to do than clone LSM and GrSecurity, attempt (*cough*) to improve on the
original designs, and then harass kernel devs about problems I'm having
with things that are just meant to be toys for me anyway?


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+JuehDd4aOud5P8RAg+WAJ451ls4FIMG0wm/r3pa/dPpcasRugCeP5j9
be2STVV+vC2B1ScYYQNmMY0=
=IjCv
-----END PGP SIGNATURE-----
