Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263624AbTCUOjE>; Fri, 21 Mar 2003 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263630AbTCUOjE>; Fri, 21 Mar 2003 09:39:04 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:47244 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263624AbTCUOjD>; Fri, 21 Mar 2003 09:39:03 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Oops with bttv in latest bk
Date: 21 Mar 2003 15:57:43 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87bs04lqc8.fsf@bytesex.org>
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org> <3E796530.2010707@portrix.net> <87znnqmitn.fsf@bytesex.org> <3E79ED9F.1000402@portrix.net> <87y939x1sk.fsf@bytesex.org> <3E7AFD4C.2000205@portrix.net>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1048258663 8418 127.0.0.1 (21 Mar 2003 14:57:43 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> writes:

> >>bttv: driver version 0.9.7 loaded
> > As it kills the X-Server I guess you are using the X-Servers v4l
> > module and the Xvideo extention, correct?
> >
> yes, using the nv driver. xfree 4.2.1.

Hmm, I can't reproduce that locally.  Pushed my latest bits to
http://bytesex.org/patches/2.5/

Can you try it again?  If it still oopses for you, can you please load
the driver with bttv_debug=2 insmod option and mail me that log?

  Gerd

-- 
/join #zonenkinder
