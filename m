Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424128AbWKIRAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424128AbWKIRAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424079AbWKIRAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:00:07 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:64776 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S1424128AbWKIRAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:00:05 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: read/write interruptible semaphores?
Date: Thu, 9 Nov 2006 11:59:59 -0500
Organization: Connect Tech Inc.
Message-ID: <000001c70420$7dbbe940$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's down_interruptible() for regular semaphores, but there doesn't
seem to be down_(read|write)_interruptible() for rwsems.

Any reason why, besides that no one's needed them yet?

..Stu

