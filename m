Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSHTJQ6>; Tue, 20 Aug 2002 05:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSHTJQ5>; Tue, 20 Aug 2002 05:16:57 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:44302 "EHLO debian")
	by vger.kernel.org with ESMTP id <S316695AbSHTJQ4>;
	Tue, 20 Aug 2002 05:16:56 -0400
Date: Tue, 20 Aug 2002 11:21:01 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Cc: Jan Hudec <bulb@cimice.maxinet.cz>
Subject: Re: compil error with a LC_ALL="fr_BE@euro" !!! why ?
Message-ID: <20020820092101.GA19395@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jan Hudec <bulb@cimice.maxinet.cz>
References: <20020820081343.GB18679@debian> <20020820090521.GA6981@vagabond>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020820090521.GA6981@vagabond>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

the compiler is gcc-3.2, don't forget this information.

here my error, see my attachment

On Tue, Aug 20, 2002 at 11:05:21AM +0200, Jan Hudec wrote:
> On Tue, Aug 20, 2002 at 10:13:43AM +0200, Stephane Wirtel wrote:
> > when i compile the kernel with a LC_ALL="fr_BE@euro", i have many errors.
> > 
> > and when i use a LC_ALL="en_US", i don't have any problem.
> 
> Please include the error messages you get.
> 
> -------------------------------------------------------------------------------
> 						 Jan 'Bulb' Hudec <bulb@ucw.cz>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=compile_error_LC_ALL_FRENCH
Content-Transfer-Encoding: 8bit

make[1]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
make all_targets
make[2]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
gcc-3.2 -D__KERNEL__ -I/root/linux-2.4.20-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -nostdinc  -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
Dans le fichier inclus à partir de /root/linux-2.4.20-pre4/include/linux/wait.h:13,
          à partir de /root/linux-2.4.20-pre4/include/linux/fs.h:12,
          à partir de /root/linux-2.4.20-pre4/include/linux/capability.h:17,
          à partir de /root/linux-2.4.20-pre4/include/linux/binfmts.h:5,
          à partir de /root/linux-2.4.20-pre4/include/linux/sched.h:9,
          à partir de /root/linux-2.4.20-pre4/include/linux/mm.h:4,
          à partir de sched.c:23:
/root/linux-2.4.20-pre4/include/linux/kernel.h:10:20: stdarg.h: Aucun fichier ou répertoire de ce type
Dans le fichier inclus à partir de /root/linux-2.4.20-pre4/include/linux/wait.h:13,
          à partir de /root/linux-2.4.20-pre4/include/linux/fs.h:12,
          à partir de /root/linux-2.4.20-pre4/include/linux/capability.h:17,
          à partir de /root/linux-2.4.20-pre4/include/linux/binfmts.h:5,
          à partir de /root/linux-2.4.20-pre4/include/linux/sched.h:9,
          à partir de /root/linux-2.4.20-pre4/include/linux/mm.h:4,
          à partir de sched.c:23:
/root/linux-2.4.20-pre4/include/linux/kernel.h:74: erreur d'analyse syntaxique avant « va_list »
/root/linux-2.4.20-pre4/include/linux/kernel.h:74: AVERTISSEMENT: déclaration de fonction n'est pas un prototype
/root/linux-2.4.20-pre4/include/linux/kernel.h:77: erreur d'analyse syntaxique avant « va_list »
/root/linux-2.4.20-pre4/include/linux/kernel.h:77: AVERTISSEMENT: déclaration de fonction n'est pas un prototype
/root/linux-2.4.20-pre4/include/linux/kernel.h:81: erreur d'analyse syntaxique avant « va_list »
/root/linux-2.4.20-pre4/include/linux/kernel.h:81: AVERTISSEMENT: déclaration de fonction n'est pas un prototype
make[2]: *** [sched.o] Erreur 1
make[2]: Quitte le répertoire `/root/linux-2.4.20-pre4/kernel'
make[1]: *** [first_rule] Erreur 2
make[1]: Quitte le répertoire `/root/linux-2.4.20-pre4/kernel'
make: *** [_dir_kernel] Erreur 2
bash-2.05a# 

--0F1p//8PRICkK4MW--
