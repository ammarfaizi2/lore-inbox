Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWDKLGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDKLGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDKLGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:06:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59789 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750744AbWDKLGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:06:35 -0400
Date: Tue, 11 Apr 2006 13:06:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc1 compile failure
Message-ID: <Pine.LNX.4.61.0604111306040.928@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1196508970-1144753594=:928"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1196508970-1144753594=:928
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,


I just tried an allyesconfig on 2.6.17-rc1 and this popped up:

security/selinux/xfrm.c: In function ‘selinux_socket_getpeer_dgram’:
security/selinux/xfrm.c:284: error: ‘struct sec_path’ has no member named 
‘x’
security/selinux/xfrm.c: In function ‘selinux_xfrm_sock_rcv_skb’:
security/selinux/xfrm.c:317: error: ‘struct sec_path’ has no member named 
‘x’



Jan Engelhardt
-- 
--1283855629-1196508970-1144753594=:928--
