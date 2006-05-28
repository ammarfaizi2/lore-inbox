Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWE1QQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWE1QQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWE1QQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:16:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64453 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWE1QQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:16:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=LYlGG4TTYYiB+flccBo0rG8ifTOFjVBM7Ws7nN5fMYd7s7w+Y3A8NaS1RvMeguT4ktpWguUeWO6k3vg0TFreR3gl+pjTTlFwd/EtzKMTT43CSeBGqEbbV5irlI7rVeMHVRIvpSGxdNfPh296bfIpTm0cvPmoHBig6Kb1Di8pfI0=
Message-ID: <4479CCE9.3020604@gmail.com>
Date: Sun, 28 May 2006 18:16:18 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nathan Laredo <laredo@gnu.org>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	 <1148825088.1170.45.camel@praia> <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
In-Reply-To: <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nathan Laredo napsal(a):
> I agree that the real fix is to unify the stradis driver so that it
> uses the existing saa7146 driver (and extending the saa7146 driver if
> it doesn't have all the support necessary yet).
Yup, the best way to solve it.

> 
> Until the pci change there was never a single complaint.
There was no pci_device_id table before (and no MODULE_DEVICE_TABLE), so
userspace didn't load the driver at all.

cheers,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeczoMsxVwznUen4RAm7QAKCUavRhZmwp4KzxdbSioaSpGNIlrACeLRU/
WU2a51USyUrMG55XTdHHV78=
=5cCd
-----END PGP SIGNATURE-----
