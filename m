Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278104AbRJKFXg>; Thu, 11 Oct 2001 01:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278100AbRJKFX1>; Thu, 11 Oct 2001 01:23:27 -0400
Received: from [200.222.195.189] ([200.222.195.189]:55959 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S278104AbRJKFXP>; Thu, 11 Oct 2001 01:23:15 -0400
Date: Thu, 11 Oct 2001 02:23:54 -0300
From: =?unknown-8bit?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: "D. Stimits" <stimits@idcomm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.10] README and Documentation/Changes inconsistent
Message-ID: <20011011022354.O249@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.21i
X-Mailer: Mutt/1.3.21i - Linux 2.4.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Stimits wrote:

> My first attempt at this question didn't seem to make it in.
> On RH 7.1, which has kgcc (2.91.66) and gcc 2.96, will it be
> necessary to install a third compiler for stable 2.4.10+
> compiles?

AFAIK not for 2.4.

> Can kgcc still work for this?

If kgcc = egcs 1.1.2, I suppose so. I compiled 2.4.10 and all
earlier 2.4 with it.

Anyway, I compiled 2.95.4 right now and 2.4.11 will use it.
Time to remove egcs. Maybe it's the recommended compiler for
2.2 (?), but I don't intend to downgrade.

BTW, these files don't say that 2.95.4 is from CVS and not a
final release.

If you have the 2.95.3 sources, then

cvs rdiff -u -r gcc-2_95_3 -r gcc-2_95-branch gcc > gcc-2.95.4.patch

is your friend.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
