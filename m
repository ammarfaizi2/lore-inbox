Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWAMRaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWAMRaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWAMRaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:30:14 -0500
Received: from serverina.hacknight.org ([80.68.90.101]:59915 "EHLO
	serverina.hacknight.org") by vger.kernel.org with ESMTP
	id S1161546AbWAMRaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:30:13 -0500
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Free Ekanayaka] Re: realtime-preempt and suspend2
From: Free Ekanayaka <free@64studio.com>
Organization: 64 Studio
Date: Fri, 13 Jan 2006 18:31:06 +0100
Message-ID: <87ek3c8279.fsf@miu-ft.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm resending this email as for some reason it is not in the kernel ml
archives, so I suspect it wasn't delivered properly..

|--==> Nigel Cunningham writes:

  NC> Hi.
  NC> On Wednesday 11 January 2006 20:39, Free Ekanayaka wrote:
  >>Hi,
  >>
  >>I'd like  to use both  the realtime-preempt  and the suspend2 patches,
  >>but the seem to conflict in (I tried to apply them on 2.6.15).
  >>
  >>Did anybody experiment such combination?

  NC> Give me more detail and I'll see if I can help.

Thanks, the patch sequence is:

1) pristine kernel 2.6.15
2) suspend2 patch 2.2-rc16 (I used the apply script incl in the source tarball) [0]
3) realtime-preempt 2.6.15-rt2

Of  course the  suspend2  patch applies happily,   but when I try with
realtime-preempt I get some rejects, here is the log:

http://people.miu-ft.org/~free/2.6.15+suspend2+rt.log

Cheers,

Free

[0] http://www.suspend2.net/downloads/all/suspend2-2.2-rc16-for-2.6.15.tar.bz2


