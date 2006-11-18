Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756398AbWKRTct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbWKRTct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbWKRTct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:32:49 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:57495 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1756397AbWKRTct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:32:49 -0500
Date: Sat, 18 Nov 2006 20:31:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Folkert van Heusden <folkert@vanheusden.com>
cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
In-Reply-To: <20061118133205.GE31268@vanheusden.com>
Message-ID: <Pine.LNX.4.61.0611182030360.10940@yvahk01.tjqt.qr>
References: <200611181146.kAIBkW52028010@harpo.it.uu.se>
 <20061118133205.GE31268@vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 4. If this is about detecting the loss of specific processes
>>    (network services say), then the problem can be solved in
>>    user-space by using a separate monitor process, or by
>>    controlling the processes via ptrace.
>
>No not only for specific processes. It helps you detect problems with
>processes you dind't know they have bugs and flakey hardware (sig 11).

Write an LSM module that hooks ->task_kill. It's probably the most 
beautiful and non-intrusive solution in the set of possible solutions.



	-`J'
-- 
