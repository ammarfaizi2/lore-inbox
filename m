Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270102AbRHGGYs>; Tue, 7 Aug 2001 02:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270103AbRHGGY3>; Tue, 7 Aug 2001 02:24:29 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:55756 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270102AbRHGGYU>;
	Tue, 7 Aug 2001 02:24:20 -0400
Message-Id: <200108070624.f776Ofl21096@www.2ka.mipt.ru>
Date: Tue, 7 Aug 2001 10:27:20 +0400
From: John Polyakov <johnpol@2ka.mipt.ru>
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain>
	<Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac7; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Mon, 6 Aug 2001 22:55:19 -0700 (PDT)
Ryan Mack <rmack@mackman.net> wrote:

RM> Apparently some of you have missed the point.  Currently, the only way
to
RM> write any form of encryption application is to have it run setuid root
so
RM> it can lock pages in RAM.  Otherwise, files (or keys) that are
encrypted
RM> on disk may be left in an unencrypted state on swap, allowing for
RM> potential recovery by anyone with hardware access.  Encrypted swap
makes
RM> locking pages unnecessary, which relieves many sysadmins from the
anxiety
RM> of having yet-another-setuid application installed on their server in
RM> addition to freeing up additional pages to be swapped.

Hmmm, let us suppose, that i copy your crypted partition per bit to my
disk.
After it I will disassemble your decrypt programm and will find a key....

In any case, if anyone have crypted data, he MUST decrypt them.
And for it he MUST have some key.
If this is a software key, it MUST NOT be encrypted( it's obviously,
becouse in other case, what will decrypt this key?) and anyone, who have
PHYSICAL access to the machine, can get this key.
Am I wrong?


RM> -Ryan

---
WBR. //s0mbre
