Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTIWRYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTIWRYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:24:51 -0400
Received: from prefect.guardianit.se ([193.15.191.37]:47631 "EHLO
	prefect.guardianit.se") by vger.kernel.org with ESMTP
	id S262078AbTIWRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:24:43 -0400
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF57E99370.537F0F4E-ONC1256DAA.005EACF7@guardianit.se>
From: "Mathias Sundman" <mathias.sundman@sungard.se>
Date: Tue, 23 Sep 2003 19:25:19 +0200
X-MIMETrack: Serialize by Router on prefect/GuardianIT(Release 5.0.12  |February 13, 2003) at
 2003-09-23 19:25:20,
	Serialize complete at 2003-09-23 19:25:20
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ah yes.. because of do_basic_setup. Having /sbin/init sharing with
> > kernel threads doesn't actually strike me as too clever anyway 
although
> > none of them should be using fd stuff.
> > 
> > In which case I guess we should call unshare_files directly before we
> > open /dev/console in init/main.c.
> 
> Is this going to be fixed for 2.4.22? In -rc2, I still get this after
> pivot_root (I'm using pivot_root, but not initrd):
> 
>                halfoat:0:~ # umount /mnt
>                umount: /mnt: device is busy

Have this problem been resolved yet, or do one
still need to use the patch supplied by Jason Baron?

/Mathias

