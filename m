Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSG1HNv>; Sun, 28 Jul 2002 03:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318915AbSG1HNv>; Sun, 28 Jul 2002 03:13:51 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:54858 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318914AbSG1HNu>; Sun, 28 Jul 2002 03:13:50 -0400
Date: Sun, 28 Jul 2002 10:17:06 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.5.29
Message-ID: <20020728071703.GU1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Timothy Murphy <tim@birdsnest.maths.tcd.ie>,
	linux-kernel@vger.kernel.org
References: <20020728025701.A3490@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728025701.A3490@birdsnest.maths.tcd.ie>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 02:57:01AM +0100, you [Timothy Murphy] wrote:
> fs/partitions/Config.in l.28
> Should dep_bool have a third argument?
> As it stands, "make xconfig" fails at this point.
> It works if I add $CONFIG_EXPERIMENTAL as a third argument.
> 
> ==========================================
> Script started on Sun Jul 28 00:34:47 2002
> tim@william linux]$ make xconfig
> make[1]: Entering directory `/usr/src/linux-2.5.29/scripts'
>   Generating kconfig.tk
> fs/partitions/Config.in: 28: can't handle dep_bool/dep_mbool/dep_tristate condition
> chmod 755 kconfig.tk
> make[1]: Leaving directory `/usr/src/linux-2.5.29/scripts'
> ...
> Script done on Sun Jul 28 00:34:57 2002
> ==========================================

See
http://groups.google.com/groups?safe=images&ie=UTF-8&oe=utf-8&as_umsgid=m28z3x761f.fsf@best.localdomain&lr=&num=50&hl=en
for fix.


-- v --

v@iki.fi
