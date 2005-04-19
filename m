Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDSNgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDSNgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDSNgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:36:15 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:50831 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261517AbVDSNgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:36:07 -0400
Date: Tue, 19 Apr 2005 15:36:59 +0200
From: DervishD <lkml@dervishd.net>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hama card reader 19in1 question on USB (not workie)
Message-ID: <20050419133659.GA401@DervishD>
Mail-Followup-To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4264F3DD.7090204@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4264F3DD.7090204@pointblue.com.pl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Grzegorz :)

 * Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl> dixit:
> Apr 19 14:03:49 thinkpaddie kernel:   Vendor: USB Read  Model: CF Card
>      CF  Rev: 1.8D
> Apr 19 14:03:49 thinkpaddie kernel:   Type:   Direct-Access
>          ANSI SCSI revision: 00
[...]
> But no SD card is detected, and I can't mount the card.

    Only the first LUN is being detected. You need a kernel with
CONFIG_SCSI_MULTI_LUN in order to have all slots detected in the card
reader. I have a 8-in-1 card reader with 4 slots and I need multiple
LUN support.

    Try that ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
