Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWKHUJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWKHUJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWKHUJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:09:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:39927 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422773AbWKHUJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:09:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aj9vqHtyMbjlyyJCBUpWFmXdPJ8Kb10nG0PU0xT11tM9nbsggrNqYKX3ieoh5njeNIBe5n1dx7cZdhBPSqZTGaW+Fzfa2ZXUrS3BoUvQlkws8WWg6/q2VfHaEahCs67/4cHt2mQJXrm8o32owyLu1OPtSwzsbbbLW+t/KAuyLxo=
Message-ID: <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com>
Date: Wed, 8 Nov 2006 21:09:04 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: How to compile module params into kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02fd01c70370$d9af6700$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com>
	 <02fd01c70370$d9af6700$020120ac@Jocke>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > -----Original Message-----
> > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> >
> > On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > Instead of passing a module param on the cmdline I want to
> > compile that
> > > into
> > > the kernel, but I can't figure out how.
> > >
> > > The module param I want compile into kernel is
> > > rtc-ds1307.force=0,0x68
> > >
> > > This is for an embeddet target that doesn't have loadable module
> > > support.
> > >
> > You could edit the module source and hardcode default values.
> >
>
> Yes, but I don't want to do that since it makes maintance
> harder.
>
Well, as far as I know, there's no way to specify default module
options at compile time. The defaults are set in the module source and
are modifiable at module load time or by setting options on the kernel
command line at boot tiem. So, if that's no good for you I don't see
any other way except modifying the source to hardcode new defaults.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
