Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTJKSqx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTJKSqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:46:53 -0400
Received: from h80ad24a2.async.vt.edu ([128.173.36.162]:21137 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263359AbTJKSqu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:46:50 -0400
Message-Id: <200310111846.h9BIke6s030007@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: asdfd esadd <retu834@yahoo.com>
Cc: Kenn Humborg <kenn@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model 
In-Reply-To: Your message of "Sat, 11 Oct 2003 11:34:05 PDT."
             <20031011183405.38980.qmail@web13007.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-351464294P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Oct 2003 14:46:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-351464294P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Oct 2003 11:34:05 PDT, asdfd esadd said:

> pid_t fork(void); vs. 
> 
> the next step in the evolution CreateProcess
> 
> BOOL CreateProcess(
>   LPCTSTR lpApplicationName,
>   LPTSTR lpCommandLine,
>   LPSECURITY_ATTRIBUTES lpProcessAttributes,
>   LPSECURITY_ATTRIBUTES lpThreadAttributes,
>   BOOL bInheritHandles,
>   DWORD dwCreationFlags,
>   LPVOID lpEnvironment,
>   LPCTSTR lpCurrentDirectory,
>   LPSTARTUPINFO lpStartupInfo,
>   LPPROCESS_INFORMATION lpProcessInformation
> 
> evolved to .Net Process Class
> 
> System.Object
>    System.MarshalByRefObject
>       System.ComponentModel.Component
>          System.Diagnostics.Process
> [C#]
> public class Process : Component
> [C++]
> public __gc class Process : public Component

Thanks for the example of why it's a bad idea.

--==_Exmh_-351464294P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/iFAPcC3lWbTT17ARAmssAKDvDanPOjSZ0NwBQsQsYlIuWt4UZwCgyV+P
nxIJoQEKg59cWf2ByvPtyiU=
=EEmR
-----END PGP SIGNATURE-----

--==_Exmh_-351464294P--
