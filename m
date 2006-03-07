Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWCGPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCGPka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCGPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:40:30 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:40355 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751192AbWCGPka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:40:30 -0500
Message-ID: <440DA96B.5010604@isotton.com>
Date: Tue, 07 Mar 2006 16:40:27 +0100
From: Aaron Isotton <aaron@isotton.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: What is this: skge Ram read/write data parity error
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 32701;
	Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since some time I'm getting the following log entries under 2.6.15:

Mar  7 05:42:48 tiger kernel: skge Ram write data parity error
Mar  7 05:42:48 tiger kernel: skge Ram read data parity error

Does this mean my hardware is faulty? The error message seems to imply
that, but since I am not experiencing any problems and a comment in
skge.c says

/* Parity errors seem to happen when Genesis is connected to a switch
 * with no other ports present. Heartbeat error??
 */

talking about some other sort of parity error though ("mac parity") I'm
not sure any more. Can anybody enlighten me?	

Thanks,
Aaron
-- 
Aaron Isotton | http://www.isotton.com/
I'll give you a definite maybe. --Samuel Goldwyn
