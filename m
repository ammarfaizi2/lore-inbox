Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWALSvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWALSvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWALSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:51:19 -0500
Received: from serverina.hacknight.org ([80.68.90.101]:40714 "EHLO
	serverina.hacknight.org") by vger.kernel.org with ESMTP
	id S932658AbWALSvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:51:18 -0500
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt and suspend2
References: <87irsrhwvf.fsf@64studio.com>
	<200601120806.24132.ncunningham@cyclades.com>
From: Free Ekanayaka <free@64studio.com>
Organization: 64 Studio
In-Reply-To: <200601120806.24132.ncunningham@cyclades.com> (Nigel Cunningham's message of "Thu, 12 Jan 2006 08:06:23 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (linux)
Date: Thu, 12 Jan 2006 18:52:33 +0100
Message-ID: <871wzdmizi.fsf@miu-ft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

