Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTAUBw3>; Mon, 20 Jan 2003 20:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTAUBw3>; Mon, 20 Jan 2003 20:52:29 -0500
Received: from webmail.frogspace.net ([216.222.206.4]:48601 "EHLO
	webmail.frogspace.net") by vger.kernel.org with ESMTP
	id <S266958AbTAUBw2>; Mon, 20 Jan 2003 20:52:28 -0500
Message-ID: <1043114482.3e2ca9f2ef953@webmail.cogweb.net>
Date: Mon, 20 Jan 2003 18:01:22 -0800
From: Peter Nome <peter@cogweb.net>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 USB storage (SCSI emulation)
References: <200301101336.h0ADaDG10038@devserv.devel.redhat.com> <1043109692.3e2c973c61f8f@webmail.cogweb.net> <20030120171829.D9795@one-eyed-alien.net>
In-Reply-To: <20030120171829.D9795@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 128.97.184.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Dharm <mdharm-kernel@one-eyed-alien.net>:

> To answer, the SCSI layer should tell you where it is.  

Agree -- the SCSI layer should say where it puts a new device, and in the case of 
USB storage it doesn't (kernel 2.4.20).
 
> As for queuecommand() trying to do something, this is all normal.  It's
> showing you that it is properly throwing away things that don't make sense
> for a USB device like this.  Turn off debugging if you don't like it.

Right -- thanks for clarifying. 
 
Cheers,
Peter


