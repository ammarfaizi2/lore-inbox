Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSJWPP6>; Wed, 23 Oct 2002 11:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbSJWPP6>; Wed, 23 Oct 2002 11:15:58 -0400
Received: from 62-190-219-129.pdu.pipex.net ([62.190.219.129]:17668 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S265039AbSJWPP6>; Wed, 23 Oct 2002 11:15:58 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210231531.g9NFVU0w000243@darkstar.example.net>
Subject: Re: 2.5 Problem Report Status
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 23 Oct 2002 16:31:30 +0100 (BST)
Cc: tmolina@cox.net, erik@debill.org, linux-kernel@vger.kernel.org
In-Reply-To: <1035386743.4033.61.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Oct 23, 2002 04:25:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > definitely wrong, because I can actually hear the disk spindown for a
> > fraction of a second, then spin up again, (at least with 2.5.43, so
> > far not with 2.5.44).
> 
> Someone broke the power management code. When they fix it then I expect
> the IDE powerdown stuff will behave better again. If you had scsi then
> the scsi stuff may have been what broke it all.

Ah, right, OK.  On the subject of SCSI, recent 2.5.x kernels have
caused the SCSI bus activity LED on my Adaptec 2940AU to stay on after
powerdown as well, is this related?

John.
