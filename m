Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbULNXBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbULNXBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbULNW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:58:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5310 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261692AbULNWym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:54:42 -0500
Subject: Re: dynamic-hz
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412130928350.2394@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <Pine.LNX.4.61.0412130928350.2394@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 17:54:39 -0500
Message-Id: <1103064879.14699.75.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 09:29 +0100, Jan Engelhardt wrote:
> > Just being devils advocate here...
> >
> > I had variable Hz in my tree for a while and found there was one solitary
> > purpose to setting Hz to 100; to silence cheap capacitors.
> >
> > The rest of my users that were setting Hz to 100 for so-called performance
> > gains were doing so under the false impression that cpu usage was lower simply
> > because of the woefully inaccurate cpu usage calcuation at 100Hz.
> 
> I have found that mplayer drops audio less often when the harddisk is under 
> load.
> 

Ugh, because mplayer stupidly does disk i/o and AV playback and GUI in
the same thread.  Insert Xine plug.

Lee

