Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268390AbTBNOKU>; Fri, 14 Feb 2003 09:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBNOKU>; Fri, 14 Feb 2003 09:10:20 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:24089 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S268390AbTBNOKQ>;
	Fri, 14 Feb 2003 09:10:16 -0500
Message-ID: <3E4CFB11.1080209@mvista.com>
Date: Fri, 14 Feb 2003 08:20:01 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>
In-Reply-To: <20030214001310.B2791@almesberger.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Werner Almesberger wrote:

|Corey Minyard wrote:
|
|>Another thought.  If you add a delay with all other processors and
|>interrupts off, the disk devices
|>will run out of things to do.
|
|
|But the network will be there, patiently waiting for its chance to
|strike. Likewise, I guess: USB (e.g. move the mouse at the wrong
|moment to crash the system).

Yes, we were talking about temporary stopgaps.

But, I had another idea.  What about using power management?  If you 
suspended everything, would that be good enough.  I looked at a few 
drivers, and it seemed so.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+TPsOmUvlb4BhfF4RAic3AJ4qKgL0CHROXoyu30rWlhfzlBxOEgCfSzJ6
GeM4AJbZLaHv8GeD5N/uaHI=
=Dg5Q
-----END PGP SIGNATURE-----


