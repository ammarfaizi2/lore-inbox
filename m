Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJLOtZ>; Sat, 12 Oct 2002 10:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSJLOtZ>; Sat, 12 Oct 2002 10:49:25 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:59404 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S261238AbSJLOtY> convert rfc822-to-8bit;
	Sat, 12 Oct 2002 10:49:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Michael.Abshoff@mathematik.uni-dortmund.de
Subject: Re: How does ide-scsi get loaded?
Date: Sat, 12 Oct 2002 15:55:09 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.0.20021012192828.0183aa08@mail.bur.st> <200210121533.12998.alan@chandlerfamily.org.uk> <3DA8342C.40408@mathematik.uni-dortmund.de>
In-Reply-To: <3DA8342C.40408@mathematik.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210121555.19492.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 October 2002 3:39 pm, Michael Abshoff wrote:
> Alan Chandler wrote:
> >No - its not in there - as I said grep -r of /etc did not show anything
> >

>If you are using lilo to boot look for a block like the following: 
 > image = /boot/vmlinuz 
 > label = linux 
 > root = /dev/hda7 
  >append = "enableapic hdd=ide-scsi" 

so isn't /etc/lilo.conf in /etc.

I keep saying - the string ide-scsi is not used anywhere in /etc

[and believe me, I have also looked manually at all these sorts of places]



- -- 
Alan Chandler
alan@chandlerfamily.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qDfXuFHxcV2FFoIRAhyJAJ90OEl3GG1lJ9IPpm9Xiuq7hCg13wCfdI0I
PgIkTEx3zga3WfRSkkD0aM4=
=m0tr
-----END PGP SIGNATURE-----

