Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318382AbSGaOxZ>; Wed, 31 Jul 2002 10:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318384AbSGaOxZ>; Wed, 31 Jul 2002 10:53:25 -0400
Received: from S066054155018.asp.anobi.com ([66.54.155.18]:59068 "HELO
	s066054155018.asp.anobi.com") by vger.kernel.org with SMTP
	id <S318382AbSGaOxZ>; Wed, 31 Jul 2002 10:53:25 -0400
Message-ID: <003301c238a2$807e8d70$c504050a@corp.anobi.com>
From: <damian@kohlfeld.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc3+SMP+VIA-ApolloPro-133T-Spinlock.h-Panic
Date: Wed, 31 Jul 2002 09:56:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is crashing at line 86 of spinlock.h when I run the driver upload
for a Dialogic Voice Board.  It says In Interrupt Handler - not syncing.
This is an application which was written for a uniprocessor environment and
I suspect this to be the issue.  Is there a way to specifically bind an
application and it's children to a specified cpu?


Damian Kohlfeld
Anobi Technology Corporation

