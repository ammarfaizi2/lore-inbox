Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284335AbRLRRoB>; Tue, 18 Dec 2001 12:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284366AbRLRRnv>; Tue, 18 Dec 2001 12:43:51 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:44036 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S284335AbRLRRnn>; Tue, 18 Dec 2001 12:43:43 -0500
Message-Id: <4.3.2.7.2.20011218124302.00bcc100@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 18 Dec 2001 12:43:39 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: 2.5.1 - undefined symbols building NFS as a module
In-Reply-To: <Pine.LNX.4.33.0112181754150.29077-100000@Appserv.suse.de>
In-Reply-To: <4.3.2.7.2.20011218113324.00e657e0@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

That fixed it very nicely.  Thanks.

David

At 11:55 AM 12/18/01, you wrote:
>On Tue, 18 Dec 2001, David Relson wrote:
>
> > and here's the complaint from "make modules_install"
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1; fi
> > depmod: *** Unresolved symbols in /lib/modules/2.5.1/kernel/fs/nfs/nfs.o
> > depmod:       seq_escape
> > depmod:       seq_printf
>
>Fixed in -dj3 (url in other mail).
>(If you don't want it all, just take the hunk that
>  adds exports of these functions)
>
>Dave.
>
>--
>| Dave Jones.        http://www.codemonkey.org.uk
>| SuSE Labs

