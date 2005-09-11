Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVIKQhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVIKQhT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIKQhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:37:18 -0400
Received: from mail.charite.de ([160.45.207.131]:63666 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751068AbVIKQhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:37:17 -0400
Date: Sun, 11 Sep 2005 18:37:14 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: assertion errors with 2.6.13-git10
Message-ID: <20050911163714.GG19734@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.13-git10 I get a lot of these when running amule; after a
while, the machine locks up hard:

Sep 11 01:02:37 kasbah kernel: KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep 11 01:02:37 kasbah kernel: Leak l=4294967295 4

Sep 11 01:05:01 kasbah kernel: KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep 11 01:05:01 kasbah kernel: Leak l=4294967295 3

Sep 11 01:05:46 kasbah kernel: KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep 11 01:05:46 kasbah kernel: Leak l=4294967295 4

Sep 11 01:07:02 kasbah kernel: KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep 11 01:07:02 kasbah kernel: Leak l=4294967295 4

Sep 11 01:07:54 kasbah kernel: KERNEL: assertion ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
Sep 11 01:07:55 kasbah kernel: Leak l=4294967295 3

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
