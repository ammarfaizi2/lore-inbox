Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263883AbSITXBi>; Fri, 20 Sep 2002 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263910AbSITXBi>; Fri, 20 Sep 2002 19:01:38 -0400
Received: from jalon.able.es ([212.97.163.2]:51102 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S263883AbSITXBh>;
	Fri, 20 Sep 2002 19:01:37 -0400
Date: Sat, 21 Sep 2002 01:06:34 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920230634.GA1555@werewolf.able.es>
References: <Pine.NEB.4.44.0209201144270.2586-100000@mimas.fachschaften.tu-muenchen.de> <3D8B7157.6040205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3D8B7157.6040205@redhat.com>; from drepper@redhat.com on Fri, Sep 20, 2002 at 21:04:55 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.20 Ulrich Drepper wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Adrian Bunk wrote:
>
>> My personal estimation is that Debian will support kernel 2.4 in it's
>> stable distribution until 2006 or 2007 (this is based on the experience
>> that Debian usually supports two stable kernel series and the time between
>> stable releases of Debian is > 1 year). What is the proposed way for
>> distributions to deal with this?
>
>Two ways:
>
>- - continue to use the old code
>
>- - backport the required functionality
>

Could you post a list of requirements ? For example:
- kernel: futexes, per_cpu_areas
- toolchain: binutils version + RH-patches, gcc version
- glibc: 2.2.xxxx
etc...

Perhaps it is not so difficult, for example futexes are in -aa for 2.4,
Mandrake has gcc-3.2, etc...

Are you pushing hard for the infrastructure you need to get in standard
source trees (ie, changes to gcc, binutils...) ??

Thanks.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
