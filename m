Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRDYVaz>; Wed, 25 Apr 2001 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDYVap>; Wed, 25 Apr 2001 17:30:45 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:6931 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S132556AbRDYVa2>; Wed, 25 Apr 2001 17:30:28 -0400
Message-ID: <3AE741EA.561BE01F@damncats.org>
Date: Wed, 25 Apr 2001 17:30:18 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.10.10104250552460.9854-100000@innerfire.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001 imel96@trustix.co.id wrote:
> so i guess i deserve opinions instead of flames. the
> approach is from personal use, not the usual server use.
> if you think a server setup is best for all use just say so,
> i'm listening.

Several distributions (Red Hat and Mandrake certainly) offer auto-login
tools. In conjunction with those tools, take the approach that Apple
used with OS X and setup "sudo" for administrative tasks on the machine.
This allows the end user to generally administer the machine without all
the need to hack the kernel, modify login, operate as root, etc. You can
even restrict their actions with it and log what they do.

In the end though, I really don't see the big deal with having a root
user for general home use. Even traditionally stand-alone operating
systems have gone to this model (Mac OS X) or are heading that way fast
(Windows XP). There are always ways to configure permissions, and even
in a stand-alone environment it's always better to protect against
accidental deletion of system critical files. In other words, the
benefits vastly outweigh the minor inconvenience.

John
