Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJJONI>; Wed, 10 Oct 2001 10:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJJOM6>; Wed, 10 Oct 2001 10:12:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:1783 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273854AbRJJOMx>; Wed, 10 Oct 2001 10:12:53 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <13388.1002721848@ocs3.intra.ocs.com.au> 
In-Reply-To: <13388.1002721848@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 15:13:03 +0100
Message-ID: <4527.1002723183@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
> David Woodhouse <dwmw2@infradead.org> wrote:
> > BSD-licensed modules shouldn't mark the kernel as tainted. If they do, 
> > that's surely a bug.

>  Any license not listed in include/linux/module.h is not GPL
> compatible. That list is currently (2.4.11) 

In the world I live in,  the BSD licence without the advertising clause is
GPL compatible.

Hence, the complaint from modutils signifies a bug, either in the wording of
the MODULE_LICENSE tag for the offending module, or in the list of valid
licences. I care not which - that's an implementation issue for you to
decide.

> > The warning should probably read 'Incompatible licence' instead of
> > 'non-GPL', too.

>  No.  Any license text not approved as GPL compatible is, by
> definition, incompatible. 

Er, yes. By definition, incompatible. 'Incompatible' is a good word to use
when warning the user; the problem is not that the licence is non-GPL, but
that is it not _compatible_ with the GPL - now why didn't I think of using
that word?

--
dwmw2


