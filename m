Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUKGNIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUKGNIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKGNIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:08:15 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:38003 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbUKGNHh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:07:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M7NmJsbDuLgLgiZpg3U+TJnv7kmx9x6qLxXQ8Os5UkFHyblzhOGXgyRf4uJTszU0UDVaL2fRTf9bQeWK4ftyp5GswMvz6p1fDLktPFeMnbATLOFvsKn0vpyJdnN2E6ZGI77kd33R9lVdR9VtnUiMCPXVQ97H+aLShF2wS6oS0PE=
Message-ID: <aad1205e04110705073ee8399b@mail.gmail.com>
Date: Sun, 7 Nov 2004 21:07:32 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60L.0411071337240.21903@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <aad1205e0411062306690c21f8@mail.gmail.com>
	 <595C7524-30A7-11D9-8C52-000D9352858E@mac.com>
	 <Pine.LNX.4.60L.0411071337240.21903@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004 13:38:54 +0100 (CET), Tomasz Kłoczko
<kloczek@rudy.mif.pg.gda.pl> wrote:
> On Sun, 7 Nov 2004, Felipe Alfaro Solana wrote:
> 
> 
> 
> > On Nov 7, 2004, at 08:06, andyliu wrote:
> >
> >>   but with the help of the tarfs,we can mount a tar file to some dir and
> >> access
> >> it easily and quickly.it's like the tarfs in mc.
> >>
> >>  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> >> then access the files easily.
> >
> > Simply wonderful!
> 
> Which is ~equal to .. unpack tarfile.tar to /dir/to/mnt :o)
if the tarfile.tar contain huge little file and unpack it will cost
time and much disk space.

but this filesystem reduce time and use none disk space but it use ram

have you ever use mc's tarfs,they are a little like.
> 
> kloczek
> --
> -----------------------------------------------------------
> *Ludzie nie mają problemów, tylko sobie sami je stwarzają*
> -----------------------------------------------------------
> Tomasz Kłoczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
> 


-- 
Yours andyliu
