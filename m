Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTHOQZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTHOQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:24206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269512AbTHOQJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:35 -0400
Date: Fri, 15 Aug 2003 09:08:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.0: Bad udp checksum in loopback interface
Message-Id: <20030815090841.0f092512.shemminger@osdl.org>
In-Reply-To: <200308151311.48831.gallir@uib.es>
References: <200308151311.48831.gallir@uib.es>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux turns off IP checksumming on the loopback device for performance
(unless you specifically turn on #define for LOOPBACK_MUST_CHECKSUM).

