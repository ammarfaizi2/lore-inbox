Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUCaTn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUCaTn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:43:28 -0500
Received: from is-root.org ([217.160.132.177]:28649 "EHLO gentex.is-root.org")
	by vger.kernel.org with ESMTP id S262388AbUCaTn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 14:43:26 -0500
Date: Wed, 31 Mar 2004 21:42:44 +0200
From: Christian Gut <cycloon@is-root.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Warne <nick@ukfsn.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <20040331194244.GB7306@is-root.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jeff Garzik <jgarzik@pobox.com>, Nick Warne <nick@ukfsn.org>,
	linux-kernel@vger.kernel.org
References: <4041E38F.31264.2D8C0D2E@localhost> <4043811B.24524.33DB8886@localhost> <405F57F2.7010308@pobox.com> <87n068mr5w.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87n068mr5w.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Mar 2004, OGAWA Hirofumi wrote:

> Jeff Garzik <jgarzik@pobox.com> writes:
> > What was the final resolution of the 8139too debugging?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107919285122190&w=2
> The cause of his problem was BIOS configuration. It was edge-trigger.

not sure if that was the only reason. 2.6.3 and everything up breaks the
rtl nic in my laptop and i cant configure anything like edge-trigger in
my bios.

The nic works without problems when i use 2.6.2 version of 8139too.c. Is
there any possibility to get these or similar patches into 2.6.5 to
support a config option to get the old behavior?

