Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTDNWNi (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTDNWNi (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:13:38 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:52207 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263970AbTDNWNe (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:13:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Tue, 15 Apr 2003 00:23:04 +0200
User-Agent: KMail/1.5.1
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
References: <200304150004.19213.arnd@arndb.de> <20030414222121.GA6266@kroah.com>
In-Reply-To: <20030414222121.GA6266@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304150023.11258.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 15 April 2003 00:21, Greg KH wrote:

> Hm, default looks good, but why would it have a .*?  How about:
>
> for I in "${DIR}/$1/"* "${DIR}/"default/* ; do

Whichever you prefer.

> That way the programs that really care about only one subsystem can be
> easily added, while everyone else can drop into the default directory
> (which odds are, everyone will want to be in...)
>
> Sound ok?

Yes.

> Ok, I'll take the '&' out for now, and serialize things within a single
> hotplug call.

Ok, thanks!

	Arnd <><
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mzTL5t5GS2LDRf4RAq4hAJ98Baat6TlkjsUbDXxXMOPX/5oBbgCghGLm
qKRhYYh0Jd+wI963k0XRcZE=
=vo1V
-----END PGP SIGNATURE-----

