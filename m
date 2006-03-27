Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWC0DZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWC0DZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 22:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWC0DZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 22:25:31 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:43036 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbWC0DZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 22:25:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=Pfw0uVpG6YlGRowLL69yamOrdMuLcjwqVqQJQtUTGrqXMu4EmPgWASmVqPXEmSIKm52isfmg3zeuuYpASfVE/739I2AObdB1yNPlHWh+7vgRS3VdG+OzKEojbLH9hyKzuUpVDktyQKkNsjZpgeatX1+a6Z8fz+GSAFDhturDgiU=
Message-ID: <44275C2C.9010507@gmail.com>
Date: Mon, 27 Mar 2006 10:29:48 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Glynn Clements <glynn@gclements.plus.com>, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: Virtual Serial Port
References: <442582B8.8040403@gmail.com> <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr> <4425FB22.7040405@gmail.com> <Pine.LNX.4.61.0603261127580.22145@yvahk01.tjqt.qr> <4426CADF.2050902@gmail.com> <4426E303.9000701@vc.cvut.cz>
In-Reply-To: <4426E303.9000701@vc.cvut.cz>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Vandrovec wrote:
> Although it is quite irrelevant to LKML (you may want to visit
> www.vmware.com/community/index.jspa and ask there...), you can connect
> guest's serial port also to Unix socket - and in such situation you need
> virtual serial port driver only if 'host - application' does not know
> how to use /dev/tty* (for unix socket <-> /dev/ptyp* app look at
> http://platan.vc.cvut.cz/ftp/pub/vmware/serpipe.tar.gz).
>                                 Petr


Thank Petr. It also works well. That program acts as a data proxy
between unix socket and /dev/ptyp*. Yesterday I wrote a similar program
that read/write vmware's server unix sock then forward/backward data
to/from /dev/ptyp0 but it didn't work. Maybe my program has problem.
Thanks again.

Mikado
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJ1wsNWc9T2Wr2JcRArmmAJ483BmLFrY+aIR71u/BQH+XCs8tIQCfZGs1
uTwfbeYTsFg0Iq9/FL/82I4=
=dgch
-----END PGP SIGNATURE-----
