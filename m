Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbTIDV3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTIDV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:29:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:47376 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S265581AbTIDV3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:29:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "Zach, Yoav" <yoav.zach@intel.com>
Subject: Re: Re: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Date: Fri, 5 Sep 2003 00:28:55 +0300
X-Mailer: KMail [version 1.4]
Cc: <akpm@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
References: <2C83850C013A2540861D03054B478C0601CF64F6@hasmsx403.iil.intel.com>
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64F6@hasmsx403.iil.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309050028.55666.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 09:53, Zach, Yoav wrote:
> > --- insecure <insecure@mail.od.ua> wrote:
> > > If the binary resides on a NFS drive ( which
> > > is a very common practice )
> > > then the suid-wrapper solution will not work
> > > because root permissions
> > > are squashed on the remote drive.
> >
> > This is a NFS promlem. Do not work around it by
> > adding crap elsewhere.
> > NFS has to get a decent user auth/crypto features.
> > I did not try it yet, but NFSv4 will address that.
>
> This is not a workaround - it's a solution for systems
> that use the unix user identification mechanism.

In NFSv3 there is _no_ user identification mechanism.
ipaddr based /etc/exports does not count.
-- 
vda
