Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWC0CMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWC0CMb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWC0CMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 21:12:31 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:47329 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1751547AbWC0CMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 21:12:31 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603270212.k2R2CUki003654@clem.clem-digital.net>
Subject: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sun, 26 Mar 2006 21:12:30 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported this earlier as a 3c509 card in error, should
have been 3c900 (3c59x driver).

FYI:
  Single 3c900 card, UP i386
  Lost networking with .16-git12, message
  ADDRCONF(NETDEV_UP): eth0: link is not ready

  Had several of these with git11
  NETDEV WATCHDOG: eth0: transmit timed out

  No problems observed git1-git10

-- 
Pete Clements 
