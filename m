Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUE0OBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUE0OBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUE0OBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:01:30 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:32689 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264443AbUE0OB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:01:28 -0400
Date: Thu, 27 May 2004 23:02:42 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH]Diskdump - yet another crash dump function
In-reply-to: <m3k6yyuhvz.fsf@averell.firstfloor.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <25C443F3471BF0indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <m3k6yyuhvz.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 May 2004 15:19:44 +0200, Andi Kleen wrote:

>I like the concept - it's basically netconsole for SCSI drivers
>and the driver changes are surprisingly simple and clean.
>
>But it would be better if it coexisted with LKCD so that netdump
>would also work. Can't you make it a low level driver for LKCD? 

One of the policy of diskdump is "simple structure".
LKCD has many funcitons (normal dump to disk, network dump, memdump,
 ...), so its structure is somewhat complex.

