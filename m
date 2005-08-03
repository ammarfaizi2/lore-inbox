Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVHCXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVHCXVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVHCXV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:21:29 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:24220 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261538AbVHCXT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:19:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d+crsbmmzO92Xt5DxjYsPqV60JL9W5I6iZF+yDZ/5kiYmh9es4L+x5eTQSnEjg8+mhQLfv2OBQT/KN5ellbKFwvAlCiG2aFZpjGeAENNrigAHZwkLnfuQ3qrM+updiIBJh17LPUPsDTM15bgkiJD3nXVclFBQ1VfALQzDZinkFg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Documentation - how to apply patches for various trees
Date: Thu, 4 Aug 2005 01:19:19 +0200
User-Agent: KMail/1.8.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
References: <200508022332.21380.jesper.juhl@gmail.com> <200508032251.07996.jesper.juhl@gmail.com> <Pine.LNX.4.58.0508032257080.3158@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0508032257080.3158@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040119.20289.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 23:46, Bodo Eggert wrote:
> On Wed, 3 Aug 2005, Jesper Juhl wrote:
> 
> > +What is a patch?
> 
> > +To correctly apply a patch you need to know what base it was generated from
> > +and what new version the patch will change the source tree into. These
> > +should both be present in the patch file metadata.
> 
> This is usurally not true for kernel patches, the directories are mostly
> named a and b. You can however deduce the to-bepatched version and the
> patched version from the filename.
> 
hmm, I'd say the patch filename could be considered "metadata" as well.


> [...]
> 
> Or: bzcat patch1 patch2 patch3 | (cd linux-oldversion && patch -p1)
> 
yes, there are many ways, impossible to list them all, but this might be a
good example to add, just to show application of several patches in one go.

> 
<snip lots of good stuff>

I need to get some sleep now, but I'll add most of your text to the document
tomorrow and post a new patch.

Thanks!


-- 
Jesper

