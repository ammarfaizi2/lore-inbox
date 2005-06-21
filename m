Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVFUNvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFUNvz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVFUNt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:49:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:56805 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261326AbVFUNTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:19:41 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Tue, 21 Jun 2005 15:20:41 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1742071.Wk27oaBrvb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506211520.44645.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1742071.Wk27oaBrvb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 June 2005 13:29, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/=
2.
>6.12-rc6-mm1/

After looking in my dmesg output today, I saw following error with=20
2.6.12-rc6-mm1, maybe it's usefull to you. I don't know when it exactly=20
happens, cause I never used mono last time, I just did an emerge mono on my=
=20
gentoo system, maybe this forced the failure.

note: mono[26736] exited with preempt_count 1
scheduling while atomic: mono/0x10000001/26736

Call Trace:<ffffffff803e13ea>{schedule+122} <ffffffff8013197b>{vprintk+635}
       <ffffffff803e2738>{cond_resched+56} <ffffffff80164de3>{unmap_vmas+15=
87}
       <ffffffff8016a560>{exit_mmap+128} <ffffffff8012e7bf>{mmput+31}
       <ffffffff80133466>{do_exit+438}=20
<ffffffff8013bf25>{__dequeue_signal+501}
       <ffffffff801340c8>{do_group_exit+280}=20
<ffffffff8013e147>{get_signal_to_deliver+1575}
       <ffffffff8010de92>{do_signal+162}=20
<ffffffff8012d1e0>{default_wake_function+0}
       <ffffffff8010e8e1>{sys_rt_sigreturn+577}=20
<ffffffff8010eb3f>{sysret_signal+28}
       <ffffffff8010ee27>{ptregscall_common+103}

cheers,
dominik

--nextPart1742071.Wk27oaBrvb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iQCVAwUAQrgULAvcoSHvsHMnAQIH+gQAm//dGYW7rdUWj5CWZPcnoXl5vWQSCAqX
owbOHP9KIW50BAJMqvxLlc14LXLPjNQJQyXLH4O0HmvS+R8DQR1onVCNqGaEcKAj
GDHQDWvq045RTMz7j/2e3oRKrli5WHPANSZ/A2KrCwlFJYAC1WyPdsfvnCucbbk0
hKB97TuJ9IU=
=JNo8
-----END PGP SIGNATURE-----

--nextPart1742071.Wk27oaBrvb--
