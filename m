Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbTGIBzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 21:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTGIBzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 21:55:06 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:57481 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S265617AbTGIBzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 21:55:01 -0400
Date: Wed, 9 Jul 2003 04:09:43 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined patch
Message-ID: <20030709020943.GA25422@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, arvidjaar@mail.ru,
	linux-kernel@vger.kernel.org
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <200307072306.15995.arvidjaar@mail.ru> <20030707140010.4268159f.akpm@osdl.org> <200307082149.17918.arvidjaar@mail.ru> <20030709012014.GA19777@www.13thfloor.at> <20030708182620.590edd06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030708182620.590edd06.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 06:26:20PM -0700, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > On Tue, Jul 08, 2003 at 09:49:17PM +0400, Andrey Borzenkov wrote:
> > > 
> > > I do not want to sound like it has to be ignored - 
> > > but devfs code is so messy that no trivial fix exists 
> > > that would not make code even more messy.
> > 
> > sorry to interrupt, but wasn't there an ongoing
> > efford to replace the devfs with smalldevfs or 
> > something even better? *hint*
> > 
> 
> Yes, but
> 
> a) It didn't have a compatible solution for the legacy device 
>    names (/dev/hda, etc).  Could have been fixed up in userspace 
>    but the work was not done.

I might be totally wrong, as I can only speak
for 2.4 (which has no ongoing/forgotten smalldevfs 
efford ;), but devfs has definitely divided the
users into two groups (think religion/war) ...

the group using devfs, usually doesn't care about
the 'compatibility' issue, the other doesn't care
at all ... so this isn't an issue at all ...

> b) Certain parties youknowwhoyouare seem to have been stricken 
>    by smalldevfs amnesia.

maybe this helps youknowwhoyoumean to remember ...

> I'm hoping that smalldevfs comes back.  
> The current thing is a running sore.

I'm hoping too, and I would like to see it on
2.6 as well as 2.4 ...

using 2.4 I'm currently bound to devfs, as I'm
one of the pro-devfs guys, and I think Richard
Gooch did a great work with it ... (maybe a 
little too much work actually ;)

best,
Herbert

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
