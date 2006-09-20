Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWITHpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWITHpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWITHpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:45:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:7645 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751276AbWITHo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: therm_throt: Refactor and improve thermal throttle processing
Date: Wed, 20 Sep 2006 09:43:59 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11587201623432-git-send-email-dmitriyz@google.com>
In-Reply-To: <11587201623432-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200943.59550.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 04:42, Dmitriy Zavin wrote:
> This patch-set factors out the thermal throttle processing code
> from i386 and x86_64 into a separate file (therm_throt.c).
> This allows consistent reporting of CPU thermal throttle events.
> Furthermore, a counter is added to /sys that keeps track of the
> number of thermal events, such that the user knows how bad the
> thermal problem might be (since the logging to syslog and mcelog
> is rate limited).

Can you put this blurb into the description of the main patch that implements
the code please too? 

-Andi
