Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265565AbTFMWST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbTFMWST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:18:19 -0400
Received: from ns.suse.de ([213.95.15.193]:11782 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265565AbTFMWSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:18:18 -0400
Date: Sat, 14 Jun 2003 00:32:04 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: bojan@gajba.net
Cc: linux-kernel@vger.kernel.org, Bernhard Kaindl <bernhard.kaindl@gmx.de>
Subject: Re: ptrace/kmod local root exploit STILL unresolved in 2.4.21! - MY
 MISTAKE
In-Reply-To: <001701c331f9$d5f92ac0$024ba8c0@athlon>
Message-ID: <Pine.LNX.4.56.0306140027190.20048@wotan.suse.de>
References: <001701c331f9$d5f92ac0$024ba8c0@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jun 2003, Bojan Pogaèar wrote:

> I've tested this exploit in wrong way. I've first logged in as root, then I
> made "su nobody" and then exploit worked.

Maybe "nobody" isn't a "real" user in your case. If there is some problem
with it, you may end up with uid 0 after "su nobody".

check the output of the command "id" after the executiong the su command,
just to be safe in any case!

If su really worked correctly, the exploit may not even work if you
su (successfully) su'ed from root.

Bernd

> If I don't login as root at the beginning, I get operation not permited.. so
> kernel is safe after all :)
>
> Thanks 4 your time
>
>
> Best regards,
>
> Bojan Pogacar
>
>
> > Hello,
> >
> > I've upgraded my linux box to 2.4.21 because of the securety reasons. Now
> I
> > found out that old local expoloit for ptrace is stil working under 2.4.21.
> > Wasn't it fixed in RC1?
> >
> > In attachment I send you exploit, which is still working!
> >
> >
> > Best regards,
> >
> > Bojan Pogacar
> >
>
