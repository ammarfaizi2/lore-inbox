Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUFXSxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUFXSxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUFXSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:53:38 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:31887 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264808AbUFXSwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:52:44 -0400
Date: Thu, 24 Jun 2004 14:46:39 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: George Georgalis <george@galis.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA_SIL fails with 2.6.7-bk6 seagate drive
In-Reply-To: <20040624155919.GA16422@trot.local>
Message-ID: <Pine.GSO.4.33.0406241442430.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, George Georgalis wrote:
...
>has caused pdflush to block IO, any access to /mnt and the process
>does not return. other than the pdflush load of ~99% the box seems to
>function normally. 2.6.7-bk6, seagate drive

-bk6 is not new enough.  bk7 has the necessary max_sectors fix.  You
may need to add your drive model to the sil_blacklist in
drivers/scsi/sata_sil.c.

--Ricky


