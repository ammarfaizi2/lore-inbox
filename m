Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbTCCMgg>; Mon, 3 Mar 2003 07:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbTCCMgg>; Mon, 3 Mar 2003 07:36:36 -0500
Received: from mail.ithnet.com ([217.64.64.8]:20485 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264820AbTCCMgf>;
	Mon, 3 Mar 2003 07:36:35 -0500
Date: Mon, 3 Mar 2003 13:46:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tighten up serverworks workaround.
Message-Id: <20030303134650.584c9f11.skraw@ithnet.com>
In-Reply-To: <200303031202.h23C2lQ28939@devserv.devel.redhat.com>
References: <20030303114504.72f47d0e.skraw@ithnet.com>
	<200303031202.h23C2lQ28939@devserv.devel.redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003 07:02:47 -0500 (EST)
Alan Cox <alan@redhat.com> wrote:

> You might want to take Kimball out of unrelated followups

Hm, I am not all that sure that it is completely unrelated. From my point of
view the "big picture" looks like this:

Coming from a system based on VIA-chipset and working perfectly well, we
changed mb to serverworks based TRL-DLS. From that time we experienced and
discussed here:

- strange mtrr settings (solved)
- interrupt sharing problem ide/tg3 (solved)
- reproducably oops'ing cd mounts (on internal ide, with ide-scsi) (not solved)
- latest news: reproducably cold-booting during tar-backup on _second_ streamer
device (dev/st1) on board-internal adaptec controller.

Please note that basic installation/distribution is the same since the VIA
setup.
We are a bit astonished since we expected serverworks-based hardware to perform
_better_ than VIA...
The email you commented is only a small hint that within -pre5 there are still
declared-unknown parts of the chipset. Based on the theory that they are named
"unknown" because nobody around here knows them, it might have been an adequate
idea to ask someone from serverworks, or not? This is in no way meant offensive.

-- 
Regards,
Stephan
