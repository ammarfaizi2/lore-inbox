Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSHMQYZ>; Tue, 13 Aug 2002 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMQYZ>; Tue, 13 Aug 2002 12:24:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318830AbSHMQYY>;
	Tue, 13 Aug 2002 12:24:24 -0400
Date: Tue, 13 Aug 2002 09:25:05 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1 
In-Reply-To: <200208131621.g7DGLc202919@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0208130922300.5175-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, James Bottomley wrote:

| rddunlap@osdl.org said:
| > and that's precisely the wrong attitude IMO.
|
| I wasn't expressing an opinion, just stating what could and could not be done
| in 2.4.

I guess that at least Jens and I (not trying to speak for Jens)
see it as a style issue and somewhat as an education issue.
At least we both used /IMO/i.

| > I was glad to see that Marcelo asked about the hardcoded values. They
| > hurt.
|
| Well, this is a rather big and particularly rancid can of worms.  If you look
| a little further, you'll see that cdrom.h has its own definition of the
| (effectively SCSI) struct request_sense that sr.c uses, yet the sense key is
| defined in scsi/scsi.h.  Then you notice that cdrom.h also duplicates all of
| the scsi commands with a GPCMD_ prefix.
|
| If you'd like to take this particular can of worms off somewhere, clean it out
| and return it neatly labelled, I'd be more than grateful...just don't take the
| lid off too close to me.

I'm not sure that it could ever get by Jens, but I'll take a look at it.

-- 
~Randy

