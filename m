Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbTBMTGQ>; Thu, 13 Feb 2003 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268263AbTBMTFo>; Thu, 13 Feb 2003 14:05:44 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:4800 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268261AbTBMTFi>; Thu, 13 Feb 2003 14:05:38 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: NO BOOT since 2.5.60-bk1
Date: Thu, 13 Feb 2003 20:13:50 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302131507.37380.schlicht@uni-mannheim.de> <20030213143419.GA32527@codemonkey.org.uk>
In-Reply-To: <20030213143419.GA32527@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_v5+S+XwfTsn5OPp";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302132013.51258.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_v5+S+XwfTsn5OPp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

On Thursday, 13. February 2003 15:34, Dave Jones wrote:
> On Thu, Feb 13, 2003 at 03:07:32PM +0100, Thomas Schlichter wrote:
>  > I've got a problem booting the linux kernel 2.5.60-bk1 and -bk2. 2.5.60
>  > works with no problems! The last messages before halting are (hand
>  > copied):
>  >
>  > VFS: Mounted root (reiserfs filesystem) readonly.
>  > Freeing unused kernel memory: 220k freed
>  > INIT: version 2.78 booting
>
> Is it a solid hang, or does the keyboard still work?
> If so, alt-scrolllock will get you an EIP of where its hanging/looping.
>
> 	Dave

OK, I did do a <ALT><SysReq>P and got following (again hand copied... ;-):

Pid: 0, comm: swapper
EIP: 0060:[<c0107052>] CPU: 0
EIP is at default_idle + 0x26/0x2c
EAX: 00000000  EBX: c010702c  ECX: cffac660
   ....

  Thomas
--Boundary-02=_v5+S+XwfTsn5OPp
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+S+5vYAiN+WRIZzQRAt4xAKCs4Vs5yr9cDMIZ/eWF6mYCenyBTgCg5iH2
EmT7xH/cEjNlQuuCBkjdM44=
=aLOp
-----END PGP SIGNATURE-----

--Boundary-02=_v5+S+XwfTsn5OPp--

