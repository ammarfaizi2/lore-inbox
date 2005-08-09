Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVHIGy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVHIGy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 02:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHIGy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 02:54:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36331 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932389AbVHIGyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 02:54:55 -0400
Subject: Re: [Alsa-devel] Re: [linux-audio-dev] Re: any update on the
	pcmcia bug blocking Audigy2 notebook sound card driver development
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       Raymond Lai <raymond.kk.lai@gmail.com>,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <1123519224.16205.5.camel@cmn37.stanford.edu>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
	 <1123519224.16205.5.camel@cmn37.stanford.edu>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 02:54:49 -0400
Message-Id: <1123570490.26998.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[added James to cc:]

On Mon, 2005-08-08 at 09:40 -0700, Fernando Lopez-Lezcano wrote:
> On Sun, 2005-08-07 at 10:43, Andrew Morton wrote:
> > Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> > > Hi all,
> > > 
> > > I remember there's a kernel pcmcia bug preventing the development for 
> > > the Audigy2 pcmcia notebook sound card driver. 
> > > 
> > > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > > 
> > > Is there any new updates on the situation? Has the bug been fixed? or
> > > anyone working on it?
> >
> > Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?
> 
> I think not, the card in question is the Creative Audigy 2 ZS PCMCIA
> card. I have one I can't use yet :-( The kernel locks hard when ALSA
> tries to load the driver. 

Maybe we should have the emu10k1 driver not claim the device until this
is fixed.  It's better than locking the machine (this behavior has been
confirmed by several other users).

Lee

