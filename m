Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJLO1E>; Sat, 12 Oct 2002 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJLO1E>; Sat, 12 Oct 2002 10:27:04 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:23812 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S261223AbSJLO1D> convert rfc822-to-8bit;
	Sat, 12 Oct 2002 10:27:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Lathiat <lathiat@irc-desk.net>
Subject: Re: How does ide-scsi get loaded?
Date: Sat, 12 Oct 2002 15:33:11 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st>
In-Reply-To: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121533.12998.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 October 2002 12:29 pm, Lathiat wrote:
> well the standard places are
> - /etc/modules
> - initrd
> or
> /etc/modules.conf
> if it is in modules something like alias char-major-blah ide-scsi, then
> change ide-scsi to 'off'

No - its not in there - as I said grep -r of /etc did not show anything

>
> Else it may be compiled into the kernel, try passing ide-scsi=none or
> something similar to the kernel (check the docs)

I do not think its in the kernel - lsmod shows ide-scsi as a loaded module.

- -- 
Alan Chandler
alan@chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qDKouFHxcV2FFoIRAiCqAJ0VcfiWZG3+rwITU1aJ+xNBq4218gCglaED
XiPe4/bWI1T1v501A+qEc0s=
=L0hq
-----END PGP SIGNATURE-----

