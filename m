Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUGaTpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUGaTpB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 15:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGaTpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 15:45:01 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:6794 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261375AbUGaTo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 15:44:59 -0400
To: aebr@win.tue.nl
CC: smfrench@austin.rr.com, rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20040731191155.GB5479@pclin040.win.tue.nl> (message from Andries
	Brouwer on Sat, 31 Jul 2004 21:11:55 +0200)
Subject: Re: uid of user who mounts
References: <1091239509.3894.11.camel@smfhome.smfdom> <20040730190825.7a447429.rddunlap@osdl.org> <1091244841.2742.8.camel@smfhome1.smfdom> <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu> <1091287308.2337.6.camel@smfhome.smfdom> <20040731191155.GB5479@pclin040.win.tue.nl>
Message-Id: <E1Bqzlr-0004sf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 31 Jul 2004 21:43:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This discussion sounds as if you do think that this is somehow
> kernel-related.  But it is not. Mount is suid and does certain
> things in a certain way.

OK.  That doesn't mean, that adding user=UID to the mount options in
/proc/mounts isn't a good idea.  It is, since that would make it
possible to get rid of /etc/mtab, which causes problems for example if
private namespaces are used.



Miklos

