Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUIOO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUIOO4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUIOO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:56:10 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:64457 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266274AbUIOOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:55:59 -0400
Date: Wed, 15 Sep 2004 10:55:12 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
cc: Erik Tews <erik@debian.franken.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
In-Reply-To: <20040915095822.GA29719@gemtek.lt>
Message-ID: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Zilvinas Valinskas wrote:
>Perhaps that is mixture of PREEMPT=y and ipsec ? dunno ...

No mixture necessary.  PREEMPT is uber-screwed up.  Try rebuilding your
kernel/modules with it disabled. (make clean first; the kernel deps don't
track CONFIG_PREEMPT correctly.)

--Ricky


