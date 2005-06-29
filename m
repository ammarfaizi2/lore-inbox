Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVF2N4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVF2N4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVF2Nz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:55:59 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:5902 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262580AbVF2NvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:51:08 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
From: Douglas McNaught <doug@mcnaught.org>
Date: Wed, 29 Jun 2005 09:50:27 -0400
In-Reply-To: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> (Horst von Brand's message of "Wed, 29 Jun 2005 01:09:05 -0400")
Message-ID: <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Hubert Chan <hubert@uhoreg.ca> wrote:
>
>>                                                        Of course, this
>> change does require file managers to understand default actions when
>> it's ambiguous what to do on a double-click -- but MacOS X has that too,
>> in the form of the "Open as Folder" option (or whatever it's called).
>
> Right. For the sake of a filesystem among many on a minority operating
> system /all/ GUI programs have to be rewritten. And all command-line
> stuff. Just because.

I'll just note that the "applications bundled as directories" stuff on
MacOS/NextStep is done completely in userspace--as far as the kernel
is concerned, "Mail.app" is a regular directory.  The file manager
handles recognition and invocation of application bundles (and there
is an 'open' shell command that does the same thing).

-Doug
