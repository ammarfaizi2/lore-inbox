Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVGWTOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVGWTOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVGWTMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:12:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33797 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261453AbVGWTMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:12:03 -0400
To: Mark Burton <mark@helenandmark.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tx queue start entry x dirty entry y (was 8139too PCI IRQ issues)
References: <e93921519c29efda5b7a304d019dcc94@helenandmark.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 24 Jul 2005 04:11:06 +0900
In-Reply-To: <e93921519c29efda5b7a304d019dcc94@helenandmark.org> (Mark Burton's message of "Tue, 19 Jul 2005 18:00:49 +0200")
Message-ID: <877jfhnxrp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Burton <mark@helenandmark.org> writes:

> Hi,
> I'm getting similar results to Nick Warne, in that when my ethernet is
> stressed at all (for instance by NFS), I end up with
> nfs: server..... not responding, still trying
> nfs: server .... OK
>
> With a realtec card, I get errors in /var/spool/messages along the
> lines of:
> Jul  3 14:31:13 localhost kernel: eth1: Transmit timeout, status 0c
> 0005 c07f media 00.
> Jul  3 14:31:13 localhost kernel: eth1: Tx queue start entry 1160
> dirty entry 1156.
> Jul  3 14:31:13 localhost kernel: eth1:  Tx descriptor 0 is
> 0008a03c. (queue head)

Probably it's the miss config of PIC. Can you post more info?

  - /proc/interrupt
  - mptable
  - 8259A.pl
  - lspci -vvv
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
