Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbULAMjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbULAMjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 07:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbULAMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 07:39:18 -0500
Received: from relay3.poste.it ([62.241.4.26]:31882 "EHLO relay3.poste.it")
	by vger.kernel.org with ESMTP id S261382AbULAMjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 07:39:15 -0500
Date: Wed, 1 Dec 2004 13:36:39 +0100
From: legion <legion@birra.it>
To: linux-kernel@vger.kernel.org
Subject: pppoe slow authentication (?)with 2.6, fast 2.4
Message-ID: <20041201123639.GA9171@lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi here, i have this problem with rp-pppoe (not kernel mode pppoe):
connection is ok, but 2.6 is slow to authenticate (exactly 20 seconds instead of
less then 1 second of 2.4).

any 2.4 kernel:
Dec  1 12:55:18 Axis pppd[2995]: pppd 2.4.2 started by root, uid 0
Dec  1 12:55:18 Axis pppd[2995]: Using interface ppp0
Dec  1 12:55:18 Axis pppd[2995]: Connect: ppp0 <--> /dev/pts/0
Dec  1 12:55:18 Axis pppoe[2996]: PADS: Service-Name: ''
Dec  1 12:55:18 Axis pppoe[2996]: PPP session is 41955
Dec  1 12:55:19 Axis pppd[2995]: PAP authentication succeeded

any 2.6 kernel:
Dec  1 12:56:47 Axis pppd[6249]: pppd 2.4.2 started by root, uid 0
Dec  1 12:56:47 Axis pppd[6249]: Using interface ppp0
Dec  1 12:56:47 Axis pppd[6249]: Connect: ppp0 <--> /dev/pts/0
Dec  1 12:56:47 Axis pppoe[6309]: PADS: Service-Name: ''
Dec  1 12:56:47 Axis pppoe[6309]: PPP session is 42019
Dec  1 12:57:07 Axis pppd[6249]: PAP authentication succeeded

note last two line timestamp.
same machine/connection/modem/kernel config..
is possibile to have a 2.4-like connection performance? thanks.
