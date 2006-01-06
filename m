Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWAFAmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWAFAmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWAFAmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:42:04 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:15425 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbWAFAmB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:42:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JxlvxWwDtqCYYWR/pI7MU5zzF1wjEqyFXujaos/7pn72qmvmVttzb4MozGbtKXG0d5oEY9NBkg19qoYiqluhBZDU+VM45FAsYuffvl0IgNBLzsIADp2ADIgbyP7x3VdjftHlCcri2p6nDYgXyMrXlwaJIW+k0pwI4I2RGsTNfSk=
Message-ID: <9a8748490601051642l7e590a4bh1ece78ca54ce71da@mail.gmail.com>
Date: Fri, 6 Jan 2006 01:42:00 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm1: what's page_owner.c doing in Documentation/ ???
Cc: linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
In-Reply-To: <20060105163532.4307672c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601051624u36fb03d2l349c40a0165cbddb@mail.gmail.com>
	 <20060105163532.4307672c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Just wondering what page_owner.c is doing in Documentation/ in 2.6.15-mm1 ;-)
> >
> > $ ls -l linux-2.6.15-mm1/Documentation/page_owner.c
> > -rw-r--r--  1 juhl users 2587 2006-01-05 18:15
> > linux-2.6.15-mm1/Documentation/page_owner.c
> >
>
> That's the tool for extracting the data which
> page-owner-tracking-leak-detector.patch produces.  There's no obvious place
> to put it, really.  It could be in scripts/ I guess.
>
> Consider it compilable documentation ;)
>

Heh, ok, fair enough ;)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
