Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUC1WcH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUC1WcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:32:07 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:22989 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262427AbUC1WcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:32:05 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.71; T1.001; A1.51; B2.12; Q2.03)
From: "ben" <name773@fastmail.fm>
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Mar 2004 14:29:31 -0800
X-Sasl-Enc: /+xQtKqMqgyEHRCURJCA4A 1080512971
Message-Id: <1080512971.16166.183465861@webmail.messagingengine.com>
Subject: swab.h byteorder.h broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more specifically
/usr/include/linux/byteorder/swab.h
/usr/include/asm-i386/byteorder.h
are broken, as in throwing errors when used to compile programs and
causing make to exit error 1 
browsing the net, plenty of people have had this problem.
i replaced the broken headers with equivalent ones from 2.4.19 and those
were broken too.
that leads me to believe that this is an old problem
anybody have a 2.6.4 patch for those files?
-- 
  
  name773@fastmail.fm

-- 
http://www.fastmail.fm - Does exactly what it says on the tin
