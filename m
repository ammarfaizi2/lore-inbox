Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVL2XgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVL2XgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVL2XgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:36:00 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:56302 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751157AbVL2XgA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:36:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L6wDvzKmUTzWZmMLLbNvy9pKWcba759USprThqbzu+4D/DlktugHvOBg6J4qVVnoIyN1ZOvbFzeSihMRCpuj1umJkeryQMct90YmvOvbB+QlQa6C7DO8/m31k8oKiGbrVfEtjcF4zMiNcrnvm0O1pCNv3omQxWgM+L+wWA8Lkqs=
Message-ID: <9a8748490512291535i3b58b99ex80e3e45d7ebeac22@mail.gmail.com>
Date: Fri, 30 Dec 2005 00:35:59 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.6..15-rc7: CONFIG_HOTPLUG help text
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0as8r1dh78udset3vv3d1sea5lpnkqccoi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <drq8r15vvepe8ike7tkm5mkcfp41npph2h@4ax.com>
	 <9a8748490512291519h22c3ad6fvcda35fb038d0f3cf@mail.gmail.com>
	 <0as8r1dh78udset3vv3d1sea5lpnkqccoi@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> On Fri, 30 Dec 2005 00:19:03 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> >On 12/30/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> >> Hi there,
> >>
> >> "
> >> CONFIG_HOTPLUG:
> >>
> >> This option is provided for the case where no in-kernel-tree
> >> modules require HOTPLUG functionality, but a module built
> >> outside the kernel tree does. Such modules require Y here.
> >> "
> >>
> >> This gives no indication it is required for udev.  Or is it me confused?
> >>
> >It doesn't mention udev specifically, but it does say quite clearly
> >that it's for out-of-kernel stuff that requires hotplug, and udev is
> >such a thing.
>
> udev is an out-of-tree kernel module?  Okay, why not bring it into
> the mainline kernel then?  ;)
>
Heh, ok, you are right, I guess my eyes skipped the "module" bit. I
guess it should say something along the lines of

 This option is provided for the case where no in-kernel-tree
 modules require HOTPLUG functionality, but a module (or
 other piece of software, like udev) built outside the kernel
 tree does.
 Such modules and other out-of-tree software require Y here.
 If in doubt say Y.

How's that for a better wording?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
