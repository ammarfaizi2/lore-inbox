Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280890AbRKPEu4>; Thu, 15 Nov 2001 23:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280909AbRKPEuq>; Thu, 15 Nov 2001 23:50:46 -0500
Received: from rj.sgi.com ([204.94.215.100]:52456 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S280890AbRKPEue>;
	Thu, 15 Nov 2001 23:50:34 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre5 atm unresolved idt77252_tx_dump
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Nov 2001 15:50:23 +1100
Message-ID: <3822.1005886223@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

idt77252_tx_dump is only defined if CONFIG_ATM_IDT77252_DEBUG is
defined but it is referenced from open code.  Result - unresolved
reference.

