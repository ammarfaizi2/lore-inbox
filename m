Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWBHEv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWBHEv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWBHEv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:51:26 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:18147 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030333AbWBHEvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:51:25 -0500
From: Grant Coady <gcoady@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 08 Feb 2006 15:51:24 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <nutiu1dkoldca31ddusfbd2rv41q7q0k3m@4ax.com>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602081335.18256.kernel@kolivas.org> <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com> <200602081400.59931.kernel@kolivas.org>
In-Reply-To: <200602081400.59931.kernel@kolivas.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 14:00:59 +1100, Con Kolivas <kernel@kolivas.org> wrote:

>This is the terminal's fault. xterm et al use an algorithm to determine how 
>fast your machine is and decide whether to jump scroll or smooth scroll. This 
>algorithm is basically broken with the 2.6 scheduler and it decides to mostly 
>smooth scroll.

Strange it does that over localnet to a PuTTY terminal on windoze.

Seems a strange thing to do in the kernel though, presentation 
buffering / management surely can be done in userspace?

Grant.
