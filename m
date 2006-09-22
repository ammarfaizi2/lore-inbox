Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWIVFvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWIVFvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWIVFvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:51:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:54154 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750812AbWIVFvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:51:08 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 0/4 v2] therm_throt: Refactor thermal throttle processing, and keep a total count of events.
Date: Fri, 22 Sep 2006 07:49:50 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11588860842488-git-send-email-dmitriyz@google.com>
In-Reply-To: <11588860842488-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220749.50309.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 02:48, Dmitriy Zavin wrote:

> Differences from last cut:
>  - No more #ifdef CONFIG_X86_64.. sorry Andi :). x86_64 specific
>    code is in arch/x86_64/kernel/mce.c
>  - Commented the need/use for time_before64/time_after64.
>    (I addressed Andi Kleen's concern about these macros in a
>     followup from last attempt, but never got a response.)
>  - More comments in therm_throt.c and individual patch descriptions

Added thanks with minor changes.

-Andi
