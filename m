Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVEQVgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVEQVgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEQVgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:36:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11453 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261965AbVEQVgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:36:32 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20050517210444.GA21257@kestrel>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe> <428A45C3.8060904@stud.feec.vutbr.cz>
	 <20050517210444.GA21257@kestrel>
Content-Type: text/plain
Date: Tue, 17 May 2005 17:36:30 -0400
Message-Id: <1116365790.32210.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 23:04 +0200, Karel Kulhavy wrote:
> On Tue, May 17, 2005 at 09:28:03PM +0200, Michal Schmidt wrote:
> > Lee Revell wrote:
> > >mpg123 is an open source application so there's no excuse for it not to
> > >support ALSA in 2005.
> > 
> > Its COPYING file says:
> >   This software may be distributed freely, provided that it is
> >   distributed in its entirety, without modifications, ...
> > This doesn't look like an open source license at all.
> > That's why Debian puts mpg123 in non-free.
> > 
> > Karel, you may want to try mpg321 instead. It already has ALSA support.
> 
> Tried with the same result: fast forward.
> 

Then the problem is probably with your ALSA configuration, or (less
likely) an ALSA bug.  I suspect your MP3s are 44100 KHz and they are
being played at 48000 KHz.  Please try ALSA CVS, there have been many
improvements since the version in the kernel.  If the problem persists,
report it on the alsa-user list.

Lee

