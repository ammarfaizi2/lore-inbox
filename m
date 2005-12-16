Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVLPMzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVLPMzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVLPMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:55:39 -0500
Received: from fuz.mail.t-online.hu ([195.228.240.97]:16909 "EHLO
	fuz.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S932284AbVLPMzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:55:39 -0500
From: "Szloboda Zsolt" <slobo@t-online.hu>
To: <linux-kernel@vger.kernel.org>
Subject: raid over sata - write barrier
Date: Fri, 16 Dec 2005 13:55:37 +0100
Message-ID: <JDEMIGCBPIDENEAIIGKPAEBMCLAA.slobo@t-online.hu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-vbmsrv: scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found that ext3 + sata + kernel 2.6.12 supports the write barrier mount
option (-o barrier=1)
(found it here: http://marc.10east.com/?l=linux-scsi&m=112019898711806)

is write barrier supported with RAID (md) over sata, with ext3? (which
kernel version?)
(or we have to disable write cache in HD in this case?)

thanks

