Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHXNu7>; Sat, 24 Aug 2002 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHXNu6>; Sat, 24 Aug 2002 09:50:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50289 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316210AbSHXNux>; Sat, 24 Aug 2002 09:50:53 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208241355.g7ODt3c26753@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre4-ac1
To: allan.d@bigpond.com (Allan Duncan)
Date: Sat, 24 Aug 2002 09:55:03 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox),
       andre@linux-ide.org
In-Reply-To: <3D6789CF.B812272F@bigpond.com> from "Allan Duncan" at Aug 24, 2002 11:27:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All the pre2-acX and pre4-ac1 run as fine when all are IDE, but the SCSI
> option causes a hang immediately after swap is enabled - the next item is
> normally "Setting hard drive parameters for hda:", but you never see that.

Im still chasing a couple ide-scsi problems.

> The message "Warning: Primary channel requires an 80-pin cable for operation"
> is (apart from being wrongly asserted as we know) incorrect is detail:
> the plugs ARE 40-pin, the cable however is 80 conductor.

True, but I'm not sure a longer less obvious message will help users
