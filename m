Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbRL3V2y>; Sun, 30 Dec 2001 16:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285062AbRL3V2p>; Sun, 30 Dec 2001 16:28:45 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:45836 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285060AbRL3V2c>; Sun, 30 Dec 2001 16:28:32 -0500
Date: Sun, 30 Dec 2001 13:29:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler params ...
In-Reply-To: <Pine.LNX.4.40.0112301308530.934-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0112301326340.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Davide Libenzi wrote:

>
> Linus, this is the patch the implement that tabled nice to ticks logic and
> that decrease the actual time slice to ~40ms for 0 nice tasks.
> Plus it brings the mm affinity to 1

After having done some test using hi-tech istruments ( moving my mouse
during a kernel build ) i'd say that timeslice ~= 40ms + mm affinity bonus
set to 1 is _way_ better from a system interactive point of view. A lower
timeslice will also result in a more uniform distribution of dynamics
priorities.




- Davide


