Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSGJLI0>; Wed, 10 Jul 2002 07:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSGJLIZ>; Wed, 10 Jul 2002 07:08:25 -0400
Received: from 62-190-200-185.pdu.pipex.net ([62.190.200.185]:62728 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315517AbSGJLIZ>; Wed, 10 Jul 2002 07:08:25 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207101116.MAA02504@darkstar.example.net>
Subject: Re: Recoverable RAM Disk
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Jul 2002 12:16:12 +0100 (BST)
In-Reply-To: <p04320407b950a89e4fc4@[192.168.3.11]> from "Christian Jaeger" at Jul 09, 2002 09:07:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks interesting for saving debug info between re-boots, but I was thinking more of reserving an area at the top of system memory, (say 4 megs), and putting a root filesystem, and some kernel images there.

The theory being that if you haven't got a hard disk, (e.g. nodes of a beowulf cluster), doing a warm boot to change kernels is 'expensive', because you're either booting from a floppy over the LAN.

Alternatively, you could preserve the in-memory filesystem cache between re-boots, (although why anyone should be re-booting that much, I don't know).

> I've recently stumbled about this:
> http://oss.missioncriticallinux.com/projects/mcore/
> 
> Maybe that's about what you're looking for.
