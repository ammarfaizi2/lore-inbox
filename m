Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTILVT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTILVRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:17:49 -0400
Received: from imap.gmx.net ([213.165.64.20]:2977 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261898AbTILVR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:17:28 -0400
References: <200309102303.34095.adq_dvb@lidskialf.net> <873cf3w03h.fsf@snail.pool> <200309112142.55460.adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org, franck@nenie.org,
       eric@lammerts.org
In-Reply-To: <200309112142.55460.adq_dvb@lidskialf.net> (message from Andrew de Quincey on Thu, 11 Sep 2003 21:42:55 +0100)
To: adq_dvb@lidskialf.net
Subject: Re: [linux-dvb] Re: Possible kernel thread related crashes on 2.4.x
From: David Kuehling <dvdkhlng@gmx.de>
Date: 12 Sep 2003 23:09:19 +0200
Message-ID: <87y8wt4su8.fsf@snail.pool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew de Quincey <adq_dvb@lidskialf.net> writes:

>> This would explain why my system hangs/crashes especially when
>> zapping a lot (it never crashed during continuous playback, only when
>> zapping).  I'm using MPlayer, which always re-opens the device for a
>> new channel.

> Yeah, I think the problem is exacerbated for me by the fact the
> streaming boxes have 5 cards each... so thats 5 kernel threads, so
> five times more likely for it to happen. As you say, it only occurs
> when starting/stopping streaming. Normal playback is rock solid.

> Please let me know if it fixes it.. be good to know if this is
> definitely the issue.

Seems to fix it.  Just zapped for 1h+ without problems.  Great.  With
all those recent updates to MPlayers DVB-support, I can now use my
Nova-t as full-featured DVB receiver :-)

David
-- 
GnuPG public key: http://user.cs.tu-berlin.de/~dvdkhlng/dk.gpg
Fingerprint: B17A DC95 D293 657B 4205  D016 7DEF 5323 C174 7D40

