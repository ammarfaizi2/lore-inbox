Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbVBFAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbVBFAXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbVBFAXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:23:46 -0500
Received: from chello062179026180.chello.pl ([62.179.26.180]:45980 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S266405AbVBFAW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:22:59 -0500
Date: Sun, 6 Feb 2005 01:23:34 +0100 (CET)
From: Tomasz Rola <rtomek@ceti.pl>
To: Marko Macek <Marko.Macek@gmx.net>
cc: Otto Wyss <otto.wyss@orpatec.ch>, linux-kernel@vger.kernel.org,
       Tomasz Rola <rtomek@ceti.pl>
Subject: Re: Why is debugging under Linux such a pain
In-Reply-To: <42050C49.9050300@gmx.net>
Message-ID: <Pine.LNX.3.96.1050206010842.16513A-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 5 Feb 2005, Marko Macek wrote:

[...]
> It would be nice if display lock programs used a separate X display 
> (some kind of "virtual" display support might be nice to have, mainly 
> for performance).

I would try VNC for this, at least for debugging. But I don't really know
if it would have worked. My distro (Debian) has VNC packed nicely
(vncserver and xvncviewer packages), others should have it too. So the
trial should be rather quick if you use such Linux flavor.

I mean, open debugged app on a VNC display and have gdb on real one. You
can also view your VNC display with a viewer in a window and it should not
mess your real X session. But I may be wrong, never tried VNC for such
kind of work even though I use it very often.

One can also do similar thing with simply having two X sessions on two
consoles, I suppose. However, frequent switching between them may not be
very healthy for hardware.

Well, I'm just thinking loudly.

Regards,
Tomasz Rola

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBQgVjjBETUsyL9vbiEQLKIQCfb0g29u44eOiRWSC2t8/I27KvJuwAoLun
pWXajzIauR1ebxYX17Xyinos
=Fkjv
-----END PGP SIGNATURE-----


