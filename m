Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUE0NTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUE0NTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUE0NTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:19:49 -0400
Received: from zero.aec.at ([193.170.194.10]:9478 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263134AbUE0NTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:19:48 -0400
To: Takao Indoh <indou.takao@soft.fujitsu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Diskdump - yet another crash dump function
References: <20pwP-55v-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 May 2004 15:19:44 +0200
In-Reply-To: <20pwP-55v-5@gated-at.bofh.it> (Takao Indoh's message of "Thu,
 27 May 2004 11:40:07 +0200")
Message-ID: <m3k6yyuhvz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takao Indoh <indou.takao@soft.fujitsu.com> writes:
>
> Diskdump can be downloaded from here.
>    http://sourceforge.net/projects/lkdump
> Please see readme.txt which can be downloaded from this site.
>
> Any comments?

I like the concept - it's basically netconsole for SCSI drivers
and the driver changes are surprisingly simple and clean.

But it would be better if it coexisted with LKCD so that netdump
would also work. Can't you make it a low level driver for LKCD? 

-Andi

