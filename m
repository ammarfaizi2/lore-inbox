Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUGHNhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUGHNhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUGHNhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:37:11 -0400
Received: from rev.193.226.233.85.euroweb.hu ([193.226.233.85]:45973 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S264660AbUGHNhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:37:11 -0400
To: nuno.ferreira@graycell.biz
CC: linux-kernel@vger.kernel.org
In-reply-to: <1089293022.2336.20.camel@taz.graycell.biz> (message from Nuno
	Ferreira on Thu, 08 Jul 2004 14:23:42 +0100)
Subject: Re: soft deadlock in blk_congestion_wait (2.6.7)
References: <E1BiVFa-0003uQ-00@dorka.pomaz.szeredi.hu> <1089293022.2336.20.camel@taz.graycell.biz>
Message-Id: <E1BiZ47-00040G-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 08 Jul 2004 15:35:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I reported that bug, and at least for CIFS it was fixed using the patch
> mentioned a few mails later on that thread, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108846032716689&w=2
> 
> I can no longer reproduce the problem, but it may be that the patch only
> made it harder to trigger.

Thanks, I should have looked the end of the thread.  It could be that
this solution also applies to FUSE, though I don't yet understand
either the bug or the fix :).

Miklos
