Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTIKUoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTIKUob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:44:31 -0400
Received: from lidskialf.net ([62.3.233.115]:18919 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261501AbTIKUo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:44:27 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: David Kuehling <dvdkhlng@gmx.de>
Subject: Re: [linux-dvb] Possible kernel thread related crashes on 2.4.x
Date: Thu, 11 Sep 2003 21:42:55 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org, franck@nenie.org,
       eric@lammerts.org
References: <200309102303.34095.adq_dvb@lidskialf.net> <873cf3w03h.fsf@snail.pool>
In-Reply-To: <873cf3w03h.fsf@snail.pool>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309112142.55460.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This would explain why my system hangs/crashes especially when zapping a
> lot (it never crashed during continuous playback, only when zapping).
> I'm using MPlayer, which always re-opens the device for a new channel.

Yeah, I think the problem is exacerbated for me by the fact the streaming 
boxes have 5 cards each... so thats 5 kernel threads, so five times more 
likely for it to happen. As you say, it only occurs when starting/stopping 
streaming. Normal playback is rock solid.

Please let me know if it fixes it.. be good to know if this is definitely the 
issue.

