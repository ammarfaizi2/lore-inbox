Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbQKVFr3>; Wed, 22 Nov 2000 00:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbQKVFrU>; Wed, 22 Nov 2000 00:47:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13320 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131339AbQKVFrF>; Wed, 22 Nov 2000 00:47:05 -0500
Message-ID: <3A1B55B3.FE866C14@timpanogas.org>
Date: Tue, 21 Nov 2000 22:12:19 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: modutils 2.3.20 not backward compatible
In-Reply-To: <5038.974864798@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:
> 
> On Tue, 21 Nov 2000 20:17:47 -0700,
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> >Was there a reason we removed the -i and -m options from newer modutils
> >and broke backwards caompatibility?  I'm re-writing our module build
> >scripts for the installer, and I discovered after upgrading to 2.3.20,
> >that all the build scripts (about 10MB worth) are now busted and I have
> >been spending most of this evening rewriting them so they work again.
> 
> -i and -m have never been in the base code.  -i in depmod is a Redhat
> add on, only in their distribution.  I have no idea what -m does, apart
> from -m in insmod which is supported.  Blame the distributors.

Thanks for clarifying.  -i ignores certain dependency failures, and is
very dangerous.  -m lets you use a map file.  If what you say is
correct, then it was an erstwhile exercise rewriting these scripts,
since they will now take generic parameters.  

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
