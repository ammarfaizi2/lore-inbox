Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWHXKOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWHXKOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWHXKOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:14:25 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:52421 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751022AbWHXKOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:14:23 -0400
To: Nathan Scott <nathans@sgi.com>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
In-reply-to: <20060824171653.C3003989@wobbly.melbourne.sgi.com>
Message-Id: <20060824191341m-saito@mail.aom.tnes.nec.co.jp>
References: <20060824171653.C3003989@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Thu, 24 Aug 2006 19:13:41 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nathan

>Which doesn't look correct due to your need_iput guard, but perhaps
>we should do this instead...

I think that your fix is simpler, so I agree it.


Masayuki
