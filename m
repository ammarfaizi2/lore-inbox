Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269494AbUJSQDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269494AbUJSQDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJSQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:01:46 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:30283 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S269479AbUJSP7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:59:09 -0400
Date: Tue, 19 Oct 2004 17:58:58 +0200 (CEST)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: linux-kernel@vger.kernel.org
Subject: unregister_netdevice 2.6.9
Message-ID: <Pine.LNX.4.58LT.0410191738420.2725@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (portraits.wsisiz.edu.pl [0.0.0.0]); Tue, 19 Oct 2004 17:59:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


After shutdown/reboot :

unregister_netdevice: waiting for xxxx to become free. Usage count = 1

and still wait.

whreis xxxx is name of sit device, created via script

ip tun add mode sit xxxx local y.y.y.y remote x.x.x.x  ttl 64
ip link set xxxx up
ip addr add 3FFE:eeee:xxxx::1 dev atman6



-- 
£T
