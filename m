Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272494AbTGaO4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:56:54 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:36277 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272503AbTGaO4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:56:32 -0400
Date: Thu, 31 Jul 2003 07:56:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm1 results
Message-ID: <58530000.1059663364@[10.10.2.4]>
In-Reply-To: <200307310128.50189.kernel@kolivas.org>
References: <5110000.1059489420@[10.10.2.4]> <170360000.1059513518@flay> <17830000.1059577281@[10.10.2.4]> <200307310128.50189.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Con Kolivas <kernel@kolivas.org> wrote (on Thursday, July 31, 2003 01:28:49 +1000):

> On Thu, 31 Jul 2003 01:01, Martin J. Bligh wrote:
>> OK, so test2-mm1 fixes the panic I was seeing in test1-mm1.
>> Only noticeable thing is that -mm tree is consistently a little slower
>> at kernbench
> 
> Could conceivably be my hacks throwing the cc cpu hogs onto the expired array 
> more frequently.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test2       46.05      115.20      571.75     1491.25
          2.6.0-test2-con       46.98      121.02      583.55     1498.75
          2.6.0-test2-mm1       46.95      121.18      582.00     1497.50

Good guess ;-)

Does this help interactivity a lot, or was it just an experiment?
Perhaps it could be less agressive or something?

M.

