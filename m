Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbQLOQdo>; Fri, 15 Dec 2000 11:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbQLOQde>; Fri, 15 Dec 2000 11:33:34 -0500
Received: from marjorie.loran.com ([209.167.240.3]:22543 "HELO
	marjorie.loran.com") by vger.kernel.org with SMTP
	id <S129641AbQLOQd0>; Fri, 15 Dec 2000 11:33:26 -0500
Message-ID: <02c501c066b0$2ae67f00$890216ac@ottawa.loran.com>
From: "Dana Lacoste" <dana.lacoste@peregrine.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <FBF96516CD5@vcnet.vc.cvut.cz>
Subject: Re:       [OT] Re: Linus's include file strategy redux
Date: Fri, 15 Dec 2000 11:00:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe you did not notice, but for months we have
> /lib/modules/`uname -r`/build/include, which points to kernel headers,
> and which should be used for compiling out-of-tree kernel modules
> (i.e. latest vmware uses this).

What about the case where I'm compiling for a kernel that I'm
not running (yet)?

lm_sensors, for example, told me yesterday when I compiled it
that I was running 2.2.17, but it was compiling for 2.2.18
(because I moved the symlink in /usr/src/linux to point to
/usr/src/linux-2.2.18)

I personally wouldn't like some programs to do a `uname -r`
check because it won't do what I want it to :)

--
Dana Lacoste
Linux Developer
Peregrine Systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
