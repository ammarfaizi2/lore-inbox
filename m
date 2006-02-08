Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWBHElQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWBHElQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWBHElP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:41:15 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:63450 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965202AbWBHElN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:41:13 -0500
From: Grant Coady <gcoady@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 08 Feb 2006 15:41:09 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ehtiu1tfga9nnrnc97vras8hdbg30viaoq@4ax.com>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602081335.18256.kernel@kolivas.org> <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com> <200602081400.59931.kernel@kolivas.org> <986ed62e0602072012g466b602ct1e78a778268e5710@mail.gmail.com>
In-Reply-To: <986ed62e0602072012g466b602ct1e78a778268e5710@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 20:12:40 -0800, "Barry K. Nathan" <barryn@pobox.com> wrote:

>On 2/7/06, Con Kolivas <kernel@kolivas.org> wrote:
>> This is the terminal's fault. xterm et al use an algorithm to determine how
>> fast your machine is and decide whether to jump scroll or smooth scroll. This
>> algorithm is basically broken with the 2.6 scheduler and it decides to mostly
>> smooth scroll.
>
>Recent versions of xterm are supposed to fix this. (Skimming xterm's
>changelog, I think it might have been fixed in version 201, but I'm
>not completely sure.)

Yeah but I'm using ssh to PuTTY on windoze.  No GUI on linux box.

Grant.
