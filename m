Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFQMZ4>; Mon, 17 Jun 2002 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFQMZz>; Mon, 17 Jun 2002 08:25:55 -0400
Received: from iq.mensalinux.org ([208.255.12.114]:27009 "EHLO
	iq.mensalinux.org") by vger.kernel.org with ESMTP
	id <S311898AbSFQMZy>; Mon, 17 Jun 2002 08:25:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jason Straight <jason@blazeconnect.net>
To: linux-kernel@vger.kernel.org
Subject: constants.c fix for 2.5.22 compile error
Date: Mon, 17 Jun 2002 08:25:56 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206170825.56280.jason@blazeconnect.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

line 997 in /drivers/scsi/constants.c tries to use i without declaring it.
add i to the int declaration in 910 seems to fix.
-- 

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Jason Straight
President
BlazeConnect Internet Services
Cheboygan Michigan
www.blazeconnect.net
Phone: 231-597-0376

