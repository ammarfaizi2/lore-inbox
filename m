Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSFZUfD>; Wed, 26 Jun 2002 16:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSFZUfC>; Wed, 26 Jun 2002 16:35:02 -0400
Received: from ccs.covici.com ([209.249.181.196]:26519 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S316823AbSFZUfB>;
	Wed, 26 Jun 2002 16:35:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15642.9585.132549.310625@ccs.covici.com>
Date: Wed, 26 Jun 2002 16:34:57 -0400
From: John covici <covici@ccs.covici.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] 2.5.24 rmmod of sndtimer causes system crash
In-Reply-To: <s5hit4655y4.wl@alsa2.suse.de>
References: <m3wusnz0jy.fsf@ccs.covici.com>
	<s5hit4655y4.wl@alsa2.suse.de>
X-Mailer: VM 7.05 under Emacs 21.3.50.1
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought so too, but whatever they did, it still is broke.  Yes, I
am using the alsa in the 2.5.24 tree.

on Wednesday 06/26/2002 Takashi Iwai(tiwai@suse.de) wrote
 > At Tue, 25 Jun 2002 14:16:17 -0400,
 > John Covici wrote:
 > > 
 > > I am using kernel 2.5.24 and when I try to shutdown the alsa drivers
 > > I get unable to handle kernel paging exception ... 
 > > 
 > > Upon further investigation, the problem is that sndtimer cannot be
 > > deleted the rmmod of this module causes the problem.  I am using the
 > > via8233 sound card if that makes any difference.
 >  
 > i thought this bug was fixed on the recent version.
 > do you use the alsa drivers on 2.5.24 tree?
 > 
 > 
 > > If I build the alsa in the kernel, it works, but always calls the
 > > card card0 is there anywhere I can specify something different so I
 > > can keep my same asound.state file?
 > 
 > sorry, i don't understand your question.
 > what happened exactly except for the oops above?
 > 
 > 
 > ciao,
 > 
 > Takashi
 > 
 > 
 > -------------------------------------------------------
 > This sf.net email is sponsored by: Jabber Inc.
 > Don't miss the IM event of the season | Special offer for OSDN members! 
 > JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
 > _______________________________________________
 > Alsa-devel mailing list
 > Alsa-devel@lists.sourceforge.net
 > https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
         John Covici
         covici@ccs.covici.com
