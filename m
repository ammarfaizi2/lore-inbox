Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUDAD6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 22:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUDAD6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 22:58:08 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:21765 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262135AbUDAD6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 22:58:05 -0500
To: Christian Gut <cycloon@is-root.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Warne <nick@ukfsn.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <4041E38F.31264.2D8C0D2E@localhost>
	<4043811B.24524.33DB8886@localhost> <405F57F2.7010308@pobox.com>
	<87n068mr5w.fsf@devron.myhome.or.jp>
	<20040331194244.GB7306@is-root.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 01 Apr 2004 12:56:13 +0900
In-Reply-To: <20040331194244.GB7306@is-root.org>
Message-ID: <87y8pgpd0i.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Gut <cycloon@is-root.org> writes:

> On Tue, 23 Mar 2004, OGAWA Hirofumi wrote:
> 
> > Jeff Garzik <jgarzik@pobox.com> writes:
> > > What was the final resolution of the 8139too debugging?
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107919285122190&w=2
> > The cause of his problem was BIOS configuration. It was edge-trigger.
> 
> not sure if that was the only reason. 2.6.3 and everything up breaks the
> rtl nic in my laptop and i cant configure anything like edge-trigger in
> my bios.

Could you please tell more detail, what happened?
And please send the /proc/interrupt, dmesg, lspci -vvvxxx.

> The nic works without problems when i use 2.6.2 version of 8139too.c. Is
> there any possibility to get these or similar patches into 2.6.5 to
> support a config option to get the old behavior?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
