Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288992AbSA0W5v>; Sun, 27 Jan 2002 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289027AbSA0W5m>; Sun, 27 Jan 2002 17:57:42 -0500
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:9641 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S288992AbSA0W5h>; Sun, 27 Jan 2002 17:57:37 -0500
Message-ID: <3C5485DC.839526C9@pp.inet.fi>
Date: Mon, 28 Jan 2002 00:57:32 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Meininger <jeffm@boxybutgood.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: loopback anomaly?
In-Reply-To: <Pine.LNX.4.33.0201261611400.836-100000@mangonel.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Meininger wrote:
> I've found some undesirable behavior when trying to use the loop block
> driver with files with strange byte counts.  The files I'd like to setup
> as loopback devices are on read-only media, and they're all different byte
> counts... not necessarily even an integral multiple of 512.  I can't just
> pad them to work with losetup.
[snip]
> I'd love to help solve this problem by myself... in fact I've spent the
> last several hours trying.  I think I need the aid of a more experienced
> kernel hacker, though.  :)

This bug has been around since 2.4.6pre days and it is still unfixed in
mainline kernels. I have posted patch fix this bug twice, once in 2.4.6pre
days and once in 2.4.17pre days. My patches were ignored as usual.

Just for the record, this bug has been fixed in loop-AES since version v1.3b
(June 27 2001). Latest version is here:

    http://loop-aes.sourceforge.net/loop-AES-v1.5b.tar.bz2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

