Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTH3TZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTH3TZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 15:25:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31698 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262070AbTH3TZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 15:25:25 -0400
Date: Sat, 30 Aug 2003 16:21:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>, Mike Fedyk <mfedyk@matchmail.com>,
       Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes
In-Reply-To: <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
 <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

y

On Sat, 30 Aug 2003, Marcelo Tosatti wrote:

> >
> > Indeed, you are right.
> >
> > I'll start looking at them Monday. I'll keep you in touch. Thanks.
>
> Andrea,
>
> Would you mind to explain me 05_vm_06_swap_out-3 ?
>
> I see you change shrink_cache, try_to_free_pages_zone, etc.
>
> Can you please give me a detailed explanation of the changes there?
>
> I appreciate very much.
>
> I'll keep looking at other patches for now.

05_vm_09_misc_junk-3 removes the PF_MEMDIE and you also seem to remove the
OOM killer. Is that right? Why?
