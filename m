Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130090AbQK3PtN>; Thu, 30 Nov 2000 10:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130131AbQK3Psx>; Thu, 30 Nov 2000 10:48:53 -0500
Received: from hermes.mixx.net ([212.84.196.2]:65039 "HELO hermes.mixx.net")
        by vger.kernel.org with SMTP id <S130090AbQK3Psw> convert rfc822-to-8bit;
        Thu, 30 Nov 2000 10:48:52 -0500
From: Juri Haberland <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Juri Haberland <juri.haberland@innominate.com>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Kernel 2.2.17, makefile bug
Date: Thu, 30 Nov 2000 16:18:20 +0100
Organization: innominate AG, Berlin, Germany
Distribution: local
Message-ID: <news2mail-3A266FBC.59E8E272@innominate.com>
In-Reply-To: <Pine.LNX.4.21.0011301602080.617-100000@calcula.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Trace: mate.bln.innominate.de 975597500 8608 10.0.0.41 (30 Nov 2000 15:18:20 GMT)
X-Complaints-To: news@innominate.de
To: Gunter Königsmann 
        <Gunter.B.C.Koenigsmann@e-technik.stud.uni-erlangen.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunter Königsmann wrote:
> 
> Hello, there!
> 
> Everything works just fine, but
> 
> 'make bzlilo'
> 
> compiles the kernel, and runs lilo, but it fails to copy it to
> /boot/vmlinuz before that.

Look in /.
If you want bzlilo to copy your kernel image to boot uncomment the line
#export  INSTALL_PATH=/boot
in /usr/src/linux/Makefile.

Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
