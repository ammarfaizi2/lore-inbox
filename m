Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSAWXbV>; Wed, 23 Jan 2002 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290210AbSAWXbL>; Wed, 23 Jan 2002 18:31:11 -0500
Received: from intranet.sslnz.com ([203.109.146.4]:21998 "EHLO
	lambton.sslnz.com") by vger.kernel.org with ESMTP
	id <S290192AbSAWXa6>; Wed, 23 Jan 2002 18:30:58 -0500
Message-Id: <200201232330.g0NNUrt26123@lambton.sslnz.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Greg Cockburn <gregc@youngit.org.nz>
Organization: Unlimited Potential
To: Joel Cordonnier <joel_linuxfr@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: unable to mount root fs / reiserfs /HELP please
Date: Thu, 24 Jan 2002 12:31:08 +1300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I don't think you want to use a 2.4.15 kernel
http://www.kernel.org/pub/linux/kernel/v2.4/ChangeLog-2.4.16

pre1:
- - Correctly sync inodes in iput()                          (Alexander Viro)

If you go back through some old postings I am sure you can find issues that 
people had when unmounting filesystems. (ie it totally corrupted filesystem)

I ran this for a day or so and I know I at least unmounted once, but better 
safe than sorry, and soon had patched 2.4.15 to 2.4.16-pre1

seeya

On Thu, 24 Jan 2002 00:30, Joel Cordonnier wrote:
> Hi !
>
> I just compile a 2.4.15 kernel on my HP omnibook XE3.
> At the moment, I have a dual partition win2k/suse 7.3.
>
> I compile and copy the LILO boot sector to a floppy
> disk. On my /boot partition of my Suse parition there
> is a reiserfs fs.
>
> I have read that reiserfs is not supported for a
> 'default' kernel and that i have to include
> patches...right `?
>
> Can someone explain me what to do ??
>
>
> Thanks
> /Joel
>
> ___________________________________________________________
> Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
> Yahoo! Courrier : http://courrier.yahoo.fr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Greg 
Wellington

# Even the most secure OS is
# useless in the hands of an
# incompetent admin.

Download public key: http://www.performancemagic.com/cvme/public_key.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8T0fAyag+ETLtG8sRAqC9AKCPD36yIMPHph9Q7qpSD4t2lysdMwCgpgob
oKcBraVe3TKQ63cs0Cq/JYc=
=KSOC
-----END PGP SIGNATURE-----
