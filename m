Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269752AbUJGIdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbUJGIdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUJGIdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:33:00 -0400
Received: from ms006msg.fastweb.it ([213.140.2.54]:13510 "EHLO
	ms006msg.fastweb.it") by vger.kernel.org with ESMTP id S269752AbUJGIc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:32:59 -0400
From: Fabio Giovagnini <fgiovag@tin.it>
Organization: Walbro Italy
To: linuxsh-dev@lists.sourceforge.net
Subject: RTC (real time  clock) question about sh4 7760
Date: Thu, 7 Oct 2004 10:29:56 +0000
User-Agent: KMail/1.6.2
Cc: "Linux-SH (m17n)" <linux-sh@m17n.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097080652.5420.34.camel@cambridge> <41642CBA.7030709@redhat.com>
In-Reply-To: <41642CBA.7030709@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410071029.56911.fgiovag@tin.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I'm porting linux sh onLogic PD lsh7760-10 board.
The sh4 7760 doesn't have an on chip RTC (while other sh4 processors does), 
and the board I'm working on seems to have no RTC (maybe I2C bus connected).
So in such application I think there is no RTC available; what is the best way 
to describe this? I think to write rtc.c rtc.h modules and write the related 
funcions doing nothing.
Is it correct?

Thanks a lot
Fabio
