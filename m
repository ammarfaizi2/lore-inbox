Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTBEIRf>; Wed, 5 Feb 2003 03:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTBEIRf>; Wed, 5 Feb 2003 03:17:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11227 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267853AbTBEIRe>; Wed, 5 Feb 2003 03:17:34 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302050827.h158R6e16659@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21pre4-ac2
To: bryan@bogonomicon.net (Bryan Andersen)
Date: Wed, 5 Feb 2003 03:27:06 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3E4041B9.1090809@bogonomicon.net> from "Bryan Andersen" at Feb 04, 2003 04:42:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did a test to see if the drive was the issue and removed it.  The 
> system still hung.
> 
> flushing ide devices: hda hdc hde _

I've had several reports of this now. It looks like I have a deadlock
when actually deciding to flush IDE caches.
