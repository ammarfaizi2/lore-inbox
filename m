Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTHYMVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTHYMVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:21:44 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:56255
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261757AbTHYMVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:21:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 22:28:37 +1000
User-Agent: KMail/1.5.3
References: <200308231555.24530.kernel@kolivas.org> <200308252137.06060.kernel@kolivas.org> <yw1xbrueaqyv.fsf@users.sourceforge.net>
In-Reply-To: <yw1xbrueaqyv.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308252228.37937.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 21:58, Måns Rullgård wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> >> >> Vanilla test1 has the spin effect.  Test2 doesn't.  I haven't tried
> >> >> vanilla test3 or test4.  As I've said, the O16.2-O16.3 patch
> >> >> introduced the problem.  With that patch reversed, everything is
> >> >> fine.  What problem does that patch fix?
> >> >
> >> > It's a generic fix for priority inversion but it induces badness in
> >> > smp, and latency in task preemption on up so it's not suitable.
> >>
> >> Now I'm confused.  If that patch is bad, then why is it in O18?
> >
> > No, the 16.2 patch is bad. 16.3 backed it out.
>
> OK, but it somehow made XEmacs behave badly.

Well it was a generic fix in 16.2 that helped XEmacs as I said. O15 also had a 
generic fix (child not preempting it's parent) but that too was covering up 
the real issue, but it wasnt as drastic as 16.2.

Con

