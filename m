Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132844AbRDDPtB>; Wed, 4 Apr 2001 11:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132846AbRDDPsv>; Wed, 4 Apr 2001 11:48:51 -0400
Received: from [213.97.45.174] ([213.97.45.174]:17166 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S132844AbRDDPsh>;
	Wed, 4 Apr 2001 11:48:37 -0400
Date: Wed, 4 Apr 2001 17:47:20 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: processes stuck in D state
Message-ID: <Pine.LNX.4.33.0104041744100.1585-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.2.4-ac28 and 2.4.3 I keep on getting processes in D state that I
cannot kill, usually mozilla or nautilus which use a large amount of RAM.
Today is galeon:

A ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args shows the
following:
11520 D     0.0 105db1 down_write_failed /usr/bin/galeon-bin

This didn't happen neither with 2.4.2 nor with 2.4.3-pre7; I'm not sure
about pre8.

Pau

