Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRIPRMl>; Sun, 16 Sep 2001 13:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272577AbRIPRMc>; Sun, 16 Sep 2001 13:12:32 -0400
Received: from m3d.uib.es ([130.206.132.6]:61335 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S272576AbRIPRM0>;
	Sun, 16 Sep 2001 13:12:26 -0400
Date: Sun, 16 Sep 2001 19:12:49 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <XFMail.20010916185020.ast@domdv.de>
Message-ID: <Pine.LNX.4.33.0109161911030.31418-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Andreas Steinmetz wrote:

> More easy though (for cases of listening mp3's and backups): cache pages
> that were accesed only "once"(*) several seconds ago must be discarded
> first. It only implies a check against an access counter and a "last
> accesed" epoch fields of the page.
>
>
> (*) Or by the same process/process group in a very short period, i.e. the
> last-access timestamp should be updated only if the previous access was
  ^^^^^^^^^^^^^^^^^^^^

Sorry, I wanted to say "access counter".

--ricardo


