Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317705AbSFLNy2>; Wed, 12 Jun 2002 09:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317707AbSFLNy1>; Wed, 12 Jun 2002 09:54:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:5650 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317705AbSFLNy1>;
	Wed, 12 Jun 2002 09:54:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Fri, 07 Jun 2002 18:49:19 +1000."
             <13225.1023439759@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 23:54:14 +1000
Message-ID: <27097.1023890054@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2002 23:53:43 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 3.0.

New files:

kbuild-2.5-core-19
  Change from core-18.

    Change allno/allyes/allmod to all*config.
    Replace $([<^@][DF]) with $(dir/notdir).
    Do a dummy write to the database to workaround a kernel bug on
    timestamps of mmaped files.

kbuild-2.5-i386-2.4.18-4
kbuild-2.5-i386-2.4.19-pre10-2

    Backport CC/CC_real fix from 2.5.

kbuild-2.5-common-2.5.21-1
kbuild-2.5-i386-2.5.21-1

    Upgrade to 2.5.21.

More arch patches for 2.5.21 to follow.

