Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTICUL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTICUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:10:10 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39687 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S264393AbTICUIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:08:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "Zach, Yoav" <yoav.zach@intel.com>, <torvalds@osdl.org>
Subject: Re: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Date: Wed, 3 Sep 2003 23:08:16 +0300
X-Mailer: KMail [version 1.4]
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <2C83850C013A2540861D03054B478C0601CF64EC@hasmsx403.iil.intel.com>
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64EC@hasmsx403.iil.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309032308.16828.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 10:16, Zach, Yoav wrote:
> --- Linus Torvalds <torvalds@osdl.org> wrote:
> > I don't like the security issues here. Sure, you
> > "trust" the interpreter,
> > and clearly only root can set the flag, but to me
> > that just makes me
> > wonder why the interpreter itself can't be a simple
> > suid wrapper that does
> > the mapping rather than having it done in kernel
> > space..
>
> If the binary resides on a NFS drive ( which is a very common practice )
> then the suid-wrapper solution will not work because root permissions
> are squashed on the remote drive.

This is a NFS promlem. Do not work around it by adding crap elsewhere.
NFS has to get a decent user auth/crypto features.
I did not try it yet, but NFSv4 will address that.
--
vda
