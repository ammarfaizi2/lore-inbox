Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280291AbRJaQsx>; Wed, 31 Oct 2001 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280295AbRJaQsl>; Wed, 31 Oct 2001 11:48:41 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37040 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280284AbRJaQsY>; Wed, 31 Oct 2001 11:48:24 -0500
Date: Wed, 31 Oct 2001 11:48:59 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110311648.f9VGmxJ26896@devserv.devel.redhat.com>
To: Kai.Makisara@kolumbus.fi, Richard Kettlewell <rjk@greenend.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <mailman.1004529422.24577.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1004529422.24577.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a Seagate STT20000A IDE tape drive, which I am trying to use

> Does your drive only accept writes from the beginning of the tape

> 	Kai

I thought that was the property of helical technologies such
as DAT and 8mm. STT20000 must be QIC which ought to work,
that's why I did not bring it up. I saw the Illegal Request too.

Historically ide-scsi worked better with tapes than ide-tape,
so I am puzzled why it fails that way.

-- Pete
