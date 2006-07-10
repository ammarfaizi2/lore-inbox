Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbWGJWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbWGJWQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWGJWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:16:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63081 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965263AbWGJWQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:16:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hYW6m2K6FNEgO/YM2hGaiJNIBCrmaCwmA8qX0W/E1t9YOvxNT2bjESCSw5kCTKSJX3YIiW/11GsS+ukWJDWQHb2LEgDpYVqjl1FSjWrTDj5EU+thEArnikJkaFkrYdIP4kHDIemN8yB8yLL3klwTbWlMug1BvSyHe6MP7KInlXc=
Message-ID: <9a8748490607101516x3c13a712h714a1a8bc4d1eeb7@mail.gmail.com>
Date: Tue, 11 Jul 2006 00:16:40 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] -Wshadow: Fix warnings in mconf
In-Reply-To: <20060710155337.GB9617@admingilde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101312.38149.jesper.juhl@gmail.com>
	 <20060710155337.GB9617@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
>
> On Mon, Jul 10, 2006 at 01:12:37PM +0200, Jesper Juhl wrote:
> > --- linux-2.6.18-rc1-orig/scripts/kconfig/mconf.c     2006-06-18 03:49:35.000000000 +0200
> > +++ linux-2.6.18-rc1/scripts/kconfig/mconf.c  2006-07-09 19:48:05.000000000 +0200
> > @@ -276,7 +276,7 @@ static void conf_save(void);
> >  static void show_textbox(const char *title, const char *text, int r, int c);
> >  static void show_helptext(const char *title, const char *text);
> >  static void show_help(struct menu *menu);
> > -static void show_file(const char *filename, const char *title, int r, int c);
> > +static void show_file(const char *fname, const char *title, int r, int c);
> >
> >  static void cprint_init(void);
> >  static int cprint1(const char *fmt, ...);
>
> perhaps its more clear if you change the global variable instead?
> perhaps to config_filename?
>

Not a bad suggestion. Thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
