Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUCYQVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbUCYQVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:21:16 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:52912 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263229AbUCYQVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:21:10 -0500
Date: Thu, 25 Mar 2004 11:20:08 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] export complete_all
In-reply-to: <1080200277.5225.2.camel@laptop.fenrus.com>
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <406306B8.90303@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <406210A4.4030609@sun.com>
 <1080200277.5225.2.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arjan van de Ven wrote:
| On Wed, 2004-03-24 at 23:50, Mike Waychison wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>No idea why it hasn't been done already, but complete_all wasn't
|>exported while complete was.
|
|
| which module is using this ?

None at the moment, so getting this applied isn't neccesarily a high
priority.  Actually, the only in-tree caller is fs/exec.c:do_coredump.

I'm currently working on writing a new autofs stack and will eventually
~ need this call exported.  It seems strange to me that we'd only export
portions of an api like this.


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYwa3dQs4kOxk3/MRAo5vAJ423HBBuES9xxzWOUW5Ms+jWUtfGwCgkoIf
V3yDiSgsetl5A4pOUdRvkXQ=
=/zUy
-----END PGP SIGNATURE-----
