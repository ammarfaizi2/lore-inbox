Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUCPDHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUCPDFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:05:13 -0500
Received: from outbound01.telus.net ([199.185.220.220]:38821 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S262895AbUCPDDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 22:03:20 -0500
Subject: Re: problem with sbp2 / ieee1394 in kernel 2.6.3
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079406471.5971.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Mar 2004 20:07:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I occasionally had problems like you describe 'sbp2 aborting
request', but on my system sbp2 would always recover.  All I would see
were a delay in data access, and an entry in /var/log/messages.  There
were a lot of changes to ieee1394 between 2.6.3 and 2.6.4, and haven't
seen sbp2 fail since (two or three patches) before 2.6.4.  Try the 2.6.4
kernel (or newer) and see if that helps.
  
Bob

