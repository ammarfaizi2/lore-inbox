Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbTCLWgB>; Wed, 12 Mar 2003 17:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbTCLWgB>; Wed, 12 Mar 2003 17:36:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52774 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261809AbTCLWgA>; Wed, 12 Mar 2003 17:36:00 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303122246.h2CMkf519689@devserv.devel.redhat.com>
Subject: Re: time loss using ide-scsi under 2.4.21-pre5-ac2
To: bryan@bogonomicon.net (Bryan Andersen)
Date: Wed, 12 Mar 2003 17:46:41 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       andre@linux-ide.org, alan@redhat.com (Alan Cox)
In-Reply-To: <3E6FB4BF.7040605@bogonomicon.net> from "Bryan Andersen" at Mar 12, 2003 04:29:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm seeing seconds of time loss per minute while ripping CDs via grip 
> and it's internal cdparanoia.  Grip uses the scsi generic device for 

hdparm -u1 

Setting that by default on modern ie PCI controllers is on the todo list
for the IDE cleanup
